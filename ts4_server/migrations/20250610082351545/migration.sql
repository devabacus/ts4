BEGIN;


--
-- MIGRATION VERSION FOR ts4
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('ts4', '20250610082351545', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250610082351545', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
