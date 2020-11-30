fn generate_bootloader() {
    let boot_sector_dir = "src/boot_sector/functions/";
    let input = "boot_sector_main.asm";
    let output = format!("{}/{}", std::env::var("OUT_DIR").unwrap(), "bootloader.bin");
    println!("cargo:rerun-if-changed={}", format!("{}/{}", boot_sector_dir, input));
    let nasm_output = std::process::Command::new("nasm")
        .current_dir(boot_sector_dir)
        .args(&["-fbin", input, "-o", &output])
        .output()
        .expect("Failed to generate bootloader");
    assert!(nasm_output.status.success(), format!("\n\n{}\n", std::str::from_utf8(&nasm_output.stderr).unwrap()));
}

fn main() {
    generate_bootloader();
}
