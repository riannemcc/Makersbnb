ALTER TABLE "public"."properties" ADD FOREIGN KEY ("owner_id") REFERENCES "public"."users" ("id");
