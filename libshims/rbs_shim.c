/*
 * Copyright (C) 2023 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <stdio.h>
#include <string.h>
#include <dlfcn.h>
#include <sys/stat.h>
#include <android/log.h>


void *dlopen(const char *filename, int flags) {
	void * (*real_dlopen)(const char *, int);
	*(void **)&real_dlopen = dlsym(RTLD_NEXT, "dlopen");
	void * lib_handle = real_dlopen(filename, flags);

	// If the lib isn't libRbsFlow, just return the handle untouched
	if(memcmp(filename, "libRbsFlow.so", 13) != 0) 
		return lib_handle;

	// if libRbsFlow, let's patch the directory path!
	char * g_custom_ini_path_handle = (char*)dlsym(lib_handle, "g_custom_ini_path");
	char * error = dlerror();
	if (error) {
		__android_log_print(ANDROID_LOG_ERROR, "libRbsFlow_shim", "Cannot find g_custom_ini_path in libRbsFlow: %s\n", error);
		return NULL;
	}

	mkdir("/data/vendor/fpdata", 0700);
	snprintf(g_custom_ini_path_handle, 21, "/data/vendor/fpdata/");

	return lib_handle;
}
