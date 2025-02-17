<?php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Gate;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The model to policy mappings for the application.
     *
     * @var array<class-string, class-string>
     */
    protected $policies = [
        //
    ];

    /**
     * Register any authentication / authorization services.
     */
    public function boot(): void
    {
        Gate::define('admin', function ($user) {
            return $user->role === 'admin';
        });

        Gate::define('manager', function ($user) {
            return in_array($user->role, ['admin', 'manager']);
        });

        Gate::define('warehouse', function ($user) {
            return in_array($user->role, ['admin', 'manager', 'warehouse']);
        });

        Gate::define('staff', function ($user) {
            return in_array($user->role, ['admin', 'manager', 'warehouse', 'staff']);
        });
    }
}
