# Money Manager

This is a static browser app that can sync transactions across devices with Supabase.

## Supabase setup

1. Create a Supabase project.
2. Open SQL Editor and run [`supabase/schema.sql`](supabase/schema.sql).
3. Copy [`supabase-config.example.js`](supabase-config.example.js) to `supabase-config.js`.
4. Add the project URL and anon key from Supabase settings.
5. Deploy the folder with GitHub Pages, Netlify, or Vercel.

The app now syncs automatically without sign-in. Run the updated `supabase/schema.sql` once more in Supabase SQL Editor, then reload the app. This uses one shared public sync row, so do not store sensitive financial information in this no-login mode.

The service role key must never be placed in this project. Only the browser anon key belongs in `supabase-config.js`.
