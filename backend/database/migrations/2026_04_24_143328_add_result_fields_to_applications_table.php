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
        Schema::table('applications', function (Blueprint $table) {
            // Ajout du statut "preselected" pour correspondre au CastingResultScreen
            // On doit recréer l'enum car MySQL ne supporte pas l'ajout direct de valeur
            $table->enum('result_status', ['pending', 'preselected', 'selected', 'refused'])->default('pending')->after('status');
            
            // Message de l'agence envoyé à l'acteur avec le résultat
            $table->text('agent_message')->nullable()->after('result_status');
            
            // Date à laquelle le résultat a été publié
            $table->timestamp('result_published_at')->nullable()->after('agent_message');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('applications', function (Blueprint $table) {
            $table->dropColumn(['result_status', 'agent_message', 'result_published_at']);
        });
    }
};
