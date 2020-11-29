fn generate_bootloader() {
    let input = "src/boot_sector_memory_org.asm";
    let output = format!("{}/{}", std::env::var("OUT_DIR").unwrap(), "bootloader.bin");
    println!("cargo:rerun-if-changed={}", input);
    let nasm_output = std::process::Command::new("nasm")
        .args(&["-fbin", input, "-o", &output])
        .output()
        .expect("Failed to generate bootloader");
    assert!(nasm_output.status.success(), format!("\n\n{}\n", std::str::from_utf8(&nasm_output.stderr).unwrap()));
}

fn main() {
    generate_bootloader();
}
