-- init.sql
-- Script inisialisasi database untuk aplikasi auth

-- Pastikan extension UUID tersedia (jika perlu)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Insert sample data hanya jika tabel users sudah ada (dibuat oleh JPA)
DO $$
BEGIN
    -- Cek jika tabel users sudah ada
    IF EXISTS (SELECT FROM information_schema.tables 
               WHERE table_schema = 'public' 
               AND table_name = 'users') THEN
               
        -- Insert sample users dengan password bcrypt 'password'
        INSERT INTO users (username, email, password, is_active, created_at) 
        VALUES 
        ('admin', 'admin@example.com', '$2a$10$rOzZJ3s6.8Tq7qY4qkqZNuB9tQJ9tQJ9tQJ9tQJ9tQJ9tQJ9tQJ9tQ', true, NOW()),
        ('user1', 'user1@example.com', '$2a$10$rOzZJ3s6.8Tq7qY4qkqZNuB9tQJ9tQJ9tQJ9tQJ9tQJ9tQJ9tQJ9tQ', true, NOW())
        ON CONFLICT (username) DO NOTHING;
        
        RAISE NOTICE 'Sample data inserted successfully';
    ELSE
        RAISE NOTICE 'Table users does not exist yet, skipping data insertion';
    END IF;
END $$;