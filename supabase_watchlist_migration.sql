-- FlickNova Watchlist Table Migration
-- Run this in your Supabase SQL editor

-- Create watchlist table
CREATE TABLE IF NOT EXISTS watchlist (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  tmdb_id INTEGER NOT NULL,
  media_type VARCHAR(10) NOT NULL CHECK (media_type IN ('movie', 'tv')),
  title TEXT NOT NULL,
  poster_path TEXT,
  runtime INTEGER,
  episode_progress TEXT,
  episodes_watched INTEGER,
  total_episodes INTEGER,
  added_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, tmdb_id, media_type)
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_watchlist_user_id ON watchlist(user_id);
CREATE INDEX IF NOT EXISTS idx_watchlist_added_at ON watchlist(added_at DESC);
CREATE INDEX IF NOT EXISTS idx_watchlist_media_type ON watchlist(media_type);

-- Enable Row Level Security
ALTER TABLE watchlist ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Users can view own watchlist" ON watchlist;
DROP POLICY IF EXISTS "Users can insert own watchlist" ON watchlist;
DROP POLICY IF EXISTS "Users can update own watchlist" ON watchlist;
DROP POLICY IF EXISTS "Users can delete own watchlist" ON watchlist;

-- Create RLS Policies
CREATE POLICY "Users can view own watchlist" ON watchlist
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own watchlist" ON watchlist
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own watchlist" ON watchlist  
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own watchlist" ON watchlist
  FOR DELETE USING (auth.uid() = user_id);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_watchlist_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to automatically update updated_at
DROP TRIGGER IF EXISTS watchlist_updated_at_trigger ON watchlist;
CREATE TRIGGER watchlist_updated_at_trigger
  BEFORE UPDATE ON watchlist
  FOR EACH ROW
  EXECUTE FUNCTION update_watchlist_updated_at();

-- Grant necessary permissions
GRANT ALL ON watchlist TO authenticated;
GRANT ALL ON watchlist TO service_role;
