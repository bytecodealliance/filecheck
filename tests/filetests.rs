extern crate cton_test;

#[test]
fn filetests() {
    // Run all the filetests in the following directories.
    cton_test::run(false, vec!["filetests".into(), "docs".into()]).expect("test harness");
}
