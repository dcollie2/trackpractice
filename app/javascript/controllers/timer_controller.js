import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "display",
    "minutes",
    "startButton",
    "pauseButton",
    "resumeButton",
    "resetButton",
  ];

  connect() {
    this.startTime = null;
    this.pauseTime = null;
    this.elapsedTime = 0;
    this.startButtonTarget.classList.remove("d-none");
    this.pauseButtonTarget.classList.add("d-none");
    this.resumeButtonTarget.classList.add("d-none");
  }

  startTimer() {
    let [milliseconds, seconds, minutes, hours] = [0, 0, 0, 0];
    let int = null;

    const displayTimer = () => {
      if (!this.paused) {
        let elapsed = Date.now() - this.startTime;
        this.elapsedTime = elapsed;
        let elapsedMinutes = Math.floor(elapsed / 60000);
        hours = Math.floor(elapsedMinutes / 60);
        minutes = elapsedMinutes % 60;
        seconds = Math.floor((elapsed % 60000) / 1000);
        milliseconds = elapsed % 1000;
        // show hours, minutes, and seconds as two digits
        hours = hours.toString().padStart(2, "0");
        minutes = minutes.toString().padStart(2, "0");
        seconds = seconds.toString().padStart(2, "0");
        // show milliseconds as three digits
        milliseconds = milliseconds.toString().padStart(3, "0");
        this.displayTarget.innerHTML = ` ${hours} : ${minutes} : ${seconds} : ${milliseconds}`;
        this.minutesTarget.value = elapsedMinutes;
      }
    };
    int = setInterval(displayTimer, 10);
    this.int = int;
  }

  initialTimerStart() {
    this.startTime = Date.now();
    this.startTimer();
    // this.minutesTarget.disabled = true;
    this.startButtonTarget.classList.add("d-none");
    this.pauseButtonTarget.classList.remove("d-none");
    this.resumeButtonTarget.classList.add("d-none");
  }

  pauseTimer() {
    clearInterval(this.int);
    this.paused = true;
    this.pauseTime = Date.now();
    // this.minutesTarget.disabled = false;
    this.startButtonTarget.classList.add("d-none");
    this.pauseButtonTarget.classList.add("d-none");
    this.resumeButtonTarget.classList.remove("d-none");
  }

  resumeTimer() {
    let elapsedPauseTime = Date.now() - this.pauseTime;
    this.startTime += elapsedPauseTime;
    this.paused = false;
    this.pauseTime = null;
    this.minutesTarget.disabled = true;
    this.pauseButtonTarget.classList.remove("d-none");
    this.resumeButtonTarget.classList.add("d-none");
    this.startTimer();
  }

  resetTimer() {
    clearInterval(this.int);
    this.elapsedTime = 0;
    this.startTime = null;
    this.startButtonTarget.classList.remove("d-none");
    this.pauseButtonTarget.classList.add("d-none");
    this.resumeButtonTarget.classList.add("d-none");
    this.displayTarget.innerHTML = "00 : 00 : 00 : 000 ";
    this.minutesTarget.value = 0;
  }

  submitForm(event) {
    event.preventDefault();
    this.pauseTimer();
    this.formFieldTarget.submit();
  }
}
