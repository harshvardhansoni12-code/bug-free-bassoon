CREATE TABLE tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    title VARCHAR(200) NOT NULL,

    description TEXT,

    status VARCHAR(20) NOT NULL DEFAULT 'pending',

    priority VARCHAR(20) NOT NULL DEFAULT 'medium',

    due_date TIMESTAMPTZ,

    created_by UUID NOT NULL,

    assigned_to UUID,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    completed_at TIMESTAMPTZ,

    CONSTRAINT fk_tasks_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_tasks_assigned_to
        FOREIGN KEY (assigned_to)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT valid_task_status
        CHECK (status IN ('pending', 'in_progress', 'completed')),

    CONSTRAINT valid_task_priority
        CHECK (priority IN ('low', 'medium', 'high'))
);