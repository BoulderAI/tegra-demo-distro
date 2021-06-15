FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

copy_install_script() {
    sed -e's,@COPY_MACHINE_ID@,${PERSIST_MACHINE_ID},' ${S}/redundant-boot-install-script > ${MENDER_STATE_SCRIPTS_DIR}/ArtifactInstall_Leave_80_bl-update
}

copy_other_scripts() {
    :
}

do_compile_tegra210() {
    cp ${S}/redundant-boot-install-script-uboot ${MENDER_STATE_SCRIPTS_DIR}/ArtifactInstall_Leave_80_bl-update
}
