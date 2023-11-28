#!/bin/sh
script_name="laravel-automations"

# Set default value for AUTORUN_ENABLED
: ${AUTORUN_ENABLED:=false}

if [ "$DISABLE_DEFAULT_CONFIG" = false ]; then
    # Check to see if an Artisan file exists and assume it means Laravel is configured.
    if [ -f "$APP_BASE_DIR/artisan" ] && [ "$AUTORUN_ENABLED" = "true" ]; then
        echo "Checking for Laravel automations..."

        ############################################################################
        # artisan config:cache
        ############################################################################
        if [ "${AUTORUN_LARAVEL_CONFIG_CACHE:="true"}" = "true" ]; then
            echo "🚀 Caching Laravel config..."
            php "$APP_BASE_DIR"/artisan config:cache
        fi

        ############################################################################
        # artisan route:cache
        ############################################################################
        if [ "${AUTORUN_LARAVEL_ROUTE_CACHE:="true"}" = "true" ]; then
            echo "🚀 Caching Laravel routes..."
            php "$APP_BASE_DIR"/artisan route:cache
        fi

        ############################################################################
        # artisan view:cache
        ############################################################################
        if [ "${AUTORUN_LARAVEL_VIEW_CACHE:="true"}" = "true" ]; then
            echo "🚀 Caching Laravel views..."
            php "$APP_BASE_DIR"/artisan view:cache
        fi

        ############################################################################
        # artisan event:cache
        ###########################################################################
        if [ "${AUTORUN_LARAVEL_EVENT_CACHE:="true"}" = "true" ]; then
            echo "🚀 Caching Laravel events..."
            php "$APP_BASE_DIR"/artisan event:cache
        fi
        
        ############################################################################
        # artisan migrate
        ############################################################################
        if [ "${AUTORUN_LARAVEL_MIGRATION:="true"}" = "true" ]; then
            echo "🚀 Running migrations..."
            php "$APP_BASE_DIR"/artisan migrate --force --isolated
        fi

        ############################################################################
        # artisan storage:link
        ############################################################################
        if [ "${AUTORUN_LARAVEL_STORAGE_LINK:="true"}" = "true" ]; then
            if [ -d "$APP_BASE_DIR"/public/storage ]; then
                echo "✅ Storage already linked..."
            else
                echo "🔐 Linking the storage..."
                php "$APP_BASE_DIR"/artisan storage:link
            fi
        fi
    fi
else
    if [ "$LOG_LEVEL" = "debug" ]; then
        echo "👉 $script_name: DISABLE_DEFAULT_CONFIG does not equal \"false\", so automations will NOT be performed."
    fi
fi