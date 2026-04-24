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
        Schema::create('auditions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('casting_id')->constrained('castings')->onDelete('cascade');
            $table->foreignId('actor_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('application_id')->nullable()->constrained('applications')->onDelete('set null');
            
            // Planning
            $table->dateTime('scheduled_at')->nullable();
            $table->integer('order_in_queue')->nullable();
            
            // Status & evaluation
            $table->enum('status', ['waiting', 'present', 'in_progress', 'completed', 'absent'])->default('waiting');
            $table->text('agent_notes')->nullable();
            $table->enum('evaluation_tag', ['interesting', 'review', 'refused'])->nullable();
            $table->boolean('is_shortlisted')->default(false);
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('auditions');
    }
};
