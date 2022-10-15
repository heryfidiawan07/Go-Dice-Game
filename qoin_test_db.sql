/*
 Navicat Premium Data Transfer

 Source Server         : LOCALHOST
 Source Server Type    : PostgreSQL
 Source Server Version : 100012
 Source Host           : localhost:5432
 Source Catalog        : qoin_test
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 100012
 File Encoding         : 65001

 Date: 15/10/2022 15:37:38
*/


-- ----------------------------
-- Table structure for invoice
-- ----------------------------
DROP TABLE IF EXISTS "public"."invoice";
CREATE TABLE "public"."invoice" (
  "id" uuid NOT NULL,
  "nomor_invoice" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "pelanggan_id" uuid NOT NULL,
  "total" int8 NOT NULL,
  "created_at" timestamp(0) NOT NULL
)
;

-- ----------------------------
-- Records of invoice
-- ----------------------------
INSERT INTO "public"."invoice" VALUES ('c31f583d-eac5-4a24-9262-5750860dda16', 'INV-1', '5fbcafa6-4a14-4eab-b0ff-8f4f42ae44b6', 100000, '2022-10-15 15:13:12');
INSERT INTO "public"."invoice" VALUES ('2d774649-4bac-4c4b-9b65-61b7aa67701e', 'INV-2', '5f500758-0d0a-49b1-bc51-77c85da16370', 65000, '2022-10-15 15:15:37');

-- ----------------------------
-- Table structure for meja
-- ----------------------------
DROP TABLE IF EXISTS "public"."meja";
CREATE TABLE "public"."meja" (
  "id" uuid NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of meja
-- ----------------------------
INSERT INTO "public"."meja" VALUES ('0686d0d3-3cd8-4c5a-81eb-093fc990ecf3', 'Meja 1');
INSERT INTO "public"."meja" VALUES ('4d513f3c-046c-44cd-9b93-99f9440affff', 'Meja 2');
INSERT INTO "public"."meja" VALUES ('617f9538-bb37-4918-a982-3b7dbaab7271', 'Meja 3');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."menu";
CREATE TABLE "public"."menu" (
  "id" uuid NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "harga" int2 NOT NULL,
  "qty" int4 NOT NULL
)
;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO "public"."menu" VALUES ('4e15c96c-f586-4530-a8c8-d7c121d6f380', 'Menu 1', 5000, 10);
INSERT INTO "public"."menu" VALUES ('dae44b8f-1cb6-43c0-8d2d-913df1e0ff91', 'Menu 2', 10000, 8);
INSERT INTO "public"."menu" VALUES ('7fa7fb53-99ff-415d-8b9a-c66ff7f6f457', 'Menu 3', 15000, 7);
INSERT INTO "public"."menu" VALUES ('2639951e-01f9-4ec1-8dc3-74d3247b6ea4', 'Menu 4', 20000, 5);

-- ----------------------------
-- Table structure for pelanggan
-- ----------------------------
DROP TABLE IF EXISTS "public"."pelanggan";
CREATE TABLE "public"."pelanggan" (
  "id" uuid NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of pelanggan
-- ----------------------------
INSERT INTO "public"."pelanggan" VALUES ('5f500758-0d0a-49b1-bc51-77c85da16370', 'Hery Fidiawan', 'heryfidiawan07@mail.com', '123456');
INSERT INTO "public"."pelanggan" VALUES ('5fbcafa6-4a14-4eab-b0ff-8f4f42ae44b6', 'Rarakirana', 'rarakirana07@gmail.com', '123456');

-- ----------------------------
-- Table structure for pesanan
-- ----------------------------
DROP TABLE IF EXISTS "public"."pesanan";
CREATE TABLE "public"."pesanan" (
  "id" uuid NOT NULL,
  "nomor_pesanan" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "pelanggan_id" uuid NOT NULL,
  "meja_id" uuid NOT NULL,
  "menu_id" uuid NOT NULL,
  "jumlah" int2 NOT NULL,
  "harga_satuan" int8 NOT NULL,
  "total_harga" int8 NOT NULL
)
;

-- ----------------------------
-- Records of pesanan
-- ----------------------------
INSERT INTO "public"."pesanan" VALUES ('9dce180b-e06e-4c07-9ea3-53971b332739', 'pesanan-1', '5f500758-0d0a-49b1-bc51-77c85da16370', '0686d0d3-3cd8-4c5a-81eb-093fc990ecf3', 'dae44b8f-1cb6-43c0-8d2d-913df1e0ff91', 2, 10000, 20000);
INSERT INTO "public"."pesanan" VALUES ('c57c2af4-5c0e-4be7-a0df-99e0b1b148dd', 'pesanan-2', '5f500758-0d0a-49b1-bc51-77c85da16370', '0686d0d3-3cd8-4c5a-81eb-093fc990ecf3', '7fa7fb53-99ff-415d-8b9a-c66ff7f6f457', 3, 15000, 45000);
INSERT INTO "public"."pesanan" VALUES ('9e8986db-b44b-4e9a-aa21-2c1096cd6f5d', 'pesanan-3', '5fbcafa6-4a14-4eab-b0ff-8f4f42ae44b6', '4d513f3c-046c-44cd-9b93-99f9440affff', '2639951e-01f9-4ec1-8dc3-74d3247b6ea4', 5, 20000, 100000);

-- ----------------------------
-- Indexes structure for table invoice
-- ----------------------------
CREATE UNIQUE INDEX "invoice_nomor_idx" ON "public"."invoice" USING btree (
  "nomor_invoice" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table invoice
-- ----------------------------
ALTER TABLE "public"."invoice" ADD CONSTRAINT "unique_invoice" UNIQUE ("nomor_invoice");

-- ----------------------------
-- Primary Key structure for table invoice
-- ----------------------------
ALTER TABLE "public"."invoice" ADD CONSTRAINT "invoice_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table invoice
-- ----------------------------
ALTER TABLE "public"."invoice" ADD CONSTRAINT "fk_pelnggan_inv" FOREIGN KEY ("pelanggan_id") REFERENCES "public"."pelanggan" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Indexes structure for table meja
-- ----------------------------
CREATE UNIQUE INDEX "meja_name_idx" ON "public"."meja" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table meja
-- ----------------------------
ALTER TABLE "public"."meja" ADD CONSTRAINT "meja_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table menu
-- ----------------------------
CREATE UNIQUE INDEX "menu_name_idx" ON "public"."menu" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table menu
-- ----------------------------
ALTER TABLE "public"."menu" ADD CONSTRAINT "menu_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table pelanggan
-- ----------------------------
CREATE UNIQUE INDEX "pelanggan_email_unique_idx" ON "public"."pelanggan" USING btree (
  "email" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "pelanggan_name_idx" ON "public"."pelanggan" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table pelanggan
-- ----------------------------
ALTER TABLE "public"."pelanggan" ADD CONSTRAINT "pelanggan_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table pesanan
-- ----------------------------
CREATE UNIQUE INDEX "pesanan_nomor_idx" ON "public"."pesanan" USING btree (
  "nomor_pesanan" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table pesanan
-- ----------------------------
ALTER TABLE "public"."pesanan" ADD CONSTRAINT "pesanan_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table pesanan
-- ----------------------------
ALTER TABLE "public"."pesanan" ADD CONSTRAINT "fk_meja" FOREIGN KEY ("meja_id") REFERENCES "public"."meja" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."pesanan" ADD CONSTRAINT "fk_menu" FOREIGN KEY ("menu_id") REFERENCES "public"."menu" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."pesanan" ADD CONSTRAINT "fk_pelanggan" FOREIGN KEY ("pelanggan_id") REFERENCES "public"."pelanggan" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
