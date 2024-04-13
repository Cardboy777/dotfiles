const montitorIsVisible = {};

export function Calendar(monitor = 0) {
  const isVisible = Variable(false);
  montitorIsVisible[monitor] = isVisible;

  return Widget.Revealer({
    child: Widget.Calendar(),
    transition: "slide_up",
    transitionDuration: 200,
    revealChild: montitorIsVisible[monitor].bind(),
  });
}

export function toggleCalendarVisibility(monitor = 0) {
  montitorIsVisible[monitor].setValue(!montitorIsVisible[monitor].value);
}
