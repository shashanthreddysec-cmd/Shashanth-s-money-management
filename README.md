# Money Manager

This is a static browser app that can sync transactions across devices with Supabase.

## Supabase setup

1. Create a Supabase project.
2. Open SQL Editor and run [`supabase/schema.sql`](supabase/schema.sql).
3. Copy [`supabase-config.example.js`](supabase-config.example.js) to `supabase-config.js`.
4. Add the project URL and anon key from Supabase settings.
5. Deploy the folder with GitHub Pages, Netlify, or Vercel.

When the app opens, create an account or sign in under “Cloud sync”. Your transactions are stored in the private `money_data` row belonging to that Supabase account, so the same data appears on another device after signing in with the same account.

The service role key must never be placed in this project. Only the browser anon key belongs in `supabase-config.js`.
