function wait_emulator_to_be_ready() {
  adb devices | grep emulator | cut -f1 | while read line; do adb -s $line emu kill; done
  emulator @d -no-audio -no-boot-anim -no-window -accel on -gpu off &

boot_completed=false
  while [ "$boot_completed" == false ]; do
    status=$(adb wait-for-device shell getprop sys.boot_completed | tr -d '\r')
    echo "Boot Status: $status"

    if [ "$status" == "1" ]; then
      boot_completed=true
    else
      sleep 1
    fi
  done
}

wait_emulator_to_be_ready
echo "EMULATOR is ready"
sleep 1