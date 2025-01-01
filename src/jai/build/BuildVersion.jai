buildValidateJaiVersion :: () {
	versionInfo: Version_Info;
	compiler_get_version_info(*versionInfo);
	VERSION_ERROR_MESSAGE :: "requires jai version 0.2.4";
	assert(versionInfo.major == 0, VERSION_ERROR_MESSAGE);
	assert(versionInfo.minor == 2, VERSION_ERROR_MESSAGE);
	assert(versionInfo.micro == 6, VERSION_ERROR_MESSAGE);
}
