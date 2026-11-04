CREATE TABLE "categories" (
	"id" serial PRIMARY KEY,
	"slug" text NOT NULL UNIQUE,
	"name" text NOT NULL,
	"emoji" text DEFAULT '' NOT NULL,
	"gender" text,
	"sort_order" integer DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE "favorites" (
	"id" serial PRIMARY KEY,
	"user_id" text NOT NULL,
	"product_id" integer NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "order_items" (
	"id" serial PRIMARY KEY,
	"order_id" integer NOT NULL,
	"product_id" integer NOT NULL,
	"product_name" text NOT NULL,
	"image" text DEFAULT '' NOT NULL,
	"size" text,
	"color" text,
	"quantity" integer DEFAULT 1 NOT NULL,
	"unit_price" numeric(10,2) NOT NULL
);
--> statement-breakpoint
CREATE TABLE "orders" (
	"id" serial PRIMARY KEY,
	"user_id" text,
	"email" text NOT NULL,
	"status" text DEFAULT 'pending' NOT NULL,
	"total" numeric(10,2) NOT NULL,
	"currency" text DEFAULT 'USD' NOT NULL,
	"payment_method" text DEFAULT 'card' NOT NULL,
	"stripe_session_id" text,
	"shipping_address" jsonb,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "products" (
	"id" serial PRIMARY KEY,
	"slug" text NOT NULL UNIQUE,
	"name" text NOT NULL,
	"category_slug" text NOT NULL,
	"description" text DEFAULT '' NOT NULL,
	"short_description" text DEFAULT '' NOT NULL,
	"price" numeric(10,2) NOT NULL,
	"compare_at_price" numeric(10,2),
	"currency" text DEFAULT 'USD' NOT NULL,
	"images" jsonb DEFAULT '[]' NOT NULL,
	"sizes" jsonb DEFAULT '[]' NOT NULL,
	"colors" jsonb DEFAULT '[]' NOT NULL,
	"stock" integer DEFAULT 0 NOT NULL,
	"is_new" boolean DEFAULT false NOT NULL,
	"is_best_seller" boolean DEFAULT false NOT NULL,
	"is_promo" boolean DEFAULT false NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
ALTER TABLE "favorites" ADD CONSTRAINT "favorites_product_id_products_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id");--> statement-breakpoint
ALTER TABLE "order_items" ADD CONSTRAINT "order_items_order_id_orders_id_fkey" FOREIGN KEY ("order_id") REFERENCES "orders"("id");--> statement-breakpoint
ALTER TABLE "products" ADD CONSTRAINT "products_category_slug_categories_slug_fkey" FOREIGN KEY ("category_slug") REFERENCES "categories"("slug");