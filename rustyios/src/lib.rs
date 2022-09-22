use std::ffi::{CStr, CString};
use std::io::{stdout, BufWriter};
use std::os::raw::{c_char, c_int, c_longlong, c_ulong};
use std::thread;
use std::time::Duration;

#[no_mangle]
pub extern "C" fn hello_rust() -> *mut c_char {
    CString::new("hello from rust!").expect("whups").into_raw()
}

#[no_mangle]
pub extern "C" fn add_numbers(x: c_int, y: c_int) -> c_longlong {
    x as c_longlong + y as c_longlong
}

#[no_mangle]
pub unsafe extern "C" fn string_length(sz_msg: *const c_char) -> c_ulong {
    let slice = CStr::from_ptr(sz_msg);
    slice.to_bytes().len() as c_ulong
}

#[no_mangle]
pub extern "C" fn hello_devworld() {
    let phrase = b"Hello, /dev/world/2019!";
    let stdout = stdout();
    let mut writer = BufWriter::new(stdout.lock());
    ferris_says::say(phrase, 30, &mut writer).unwrap();
}

#[repr(C)]
pub enum TrafficLight {
    Red,
    Yellow,
    Green,
}

#[no_mangle]
pub extern "C" fn what_colour() -> TrafficLight {
    TrafficLight::Green
}

#[no_mangle]
pub unsafe extern "C" fn leven(
    s1: *const c_char,
    s2: *const c_char,
) -> c_ulong {
    let s1 = CStr::from_ptr(s1);
    let s1 = s1.to_str().unwrap();
    let s2 = CStr::from_ptr(s2);
    let s2 = s2.to_str().unwrap();
    (s1.len() + s2.len()) as c_ulong
}

#[no_mangle]
pub extern "C" fn add_numbers_cb(
    n1: c_int,
    n2: c_int,
    callback: extern "C" fn(c_int),
) {
    let answer = n1 + n2;
    callback(answer);
}

#[repr(C)]
pub enum CountdownCommand {
    Continue,
    Abort,
}

#[no_mangle]
pub extern "C" fn countdown(
    callback: extern "C" fn(c_int) -> CountdownCommand,
) {
    // Moving the callback fn ptr into the thread
    thread::spawn(move || {
        for x in (0..=15).rev() {
            thread::sleep(Duration::from_secs(1));
            match callback(x) {
                CountdownCommand::Continue => continue,
                CountdownCommand::Abort => break,
            }
        }
    });
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = add_numbers(2, 2);
        assert_eq!(result, 4);
    }
}
