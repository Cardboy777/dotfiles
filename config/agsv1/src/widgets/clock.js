import { toggleCalendarVisibility } from "./calendar.js";

const time = Variable("", {
  poll: [1000, 'date "+%l:%M %p"'],
});

const date = Variable("", {
  poll: [1000, 'date "+%c"'],
});

export function Clock(monitor = 0) {
  return Widget.Button({
    child: Widget.Label({
      class_name: "clock",
      label: time.bind(),
    }),
    tooltipMarkup: date.bind(),
    onClicked: () => {
      toggleCalendarVisibility(monitor);
    },
  });
}
