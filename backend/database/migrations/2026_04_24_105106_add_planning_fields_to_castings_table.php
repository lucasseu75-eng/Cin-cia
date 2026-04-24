<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('castings', function (Blueprint $table) {
            $table->enum('casting_mode', ['online', 'on_site'])->default('online')->after('type');
            $table->date('casting_date')->nullable()->after('casting_mode');
            $table->integer('default_duration')->default(10)->comment('Duration in minutes')->after('casting_date');
            $table->boolean('is_published')->default(false)->after('default_duration');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('castings', function (Blueprint $table) {
            $table->dropColumn(['casting_mode', 'casting_date', 'default_duration', 'is_published']);
        });
    }
};
