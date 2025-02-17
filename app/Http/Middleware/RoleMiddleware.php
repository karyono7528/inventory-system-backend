<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class RoleMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next, ...$roles): Response
    {
        // If no user is authenticated
        if (!$request->user()) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        // If no roles are specified, allow access
        if (empty($roles)) {
            return $next($request);
        }

        // Check if user's role is in the allowed roles
        $userRole = $request->user()->role;
        
        if (in_array($userRole, $roles)) {
            return $next($request);
        }

        // Deny access if role is not allowed
        return response()->json([
            'message' => 'Forbidden. Insufficient permissions.',
            'required_roles' => $roles,
            'user_role' => $userRole
        ], 403);
    }
}
