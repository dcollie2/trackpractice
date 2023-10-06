import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['display', 'minutes', 'startButton', 'pauseButton', 'resumeButton', 'resetButton'];

  connect() {
    this.startTime = null;
    this.elapsedTime = 0;
    this.startButtonTarget.classList.remove('d-none');
    this.pauseButtonTarget.classList.add('d-none');
    this.resumeButtonTarget.classList.add('d-none');
    this.startButtonTarget.addEventListener('click', this.startTimer.bind(this));
    this.pauseButtonTarget.addEventListener('click', this.pauseTimer.bind(this));
    this.resumeButtonTarget.addEventListener('click', this.resumeTimer.bind(this));
    this.resetButtonTarget.addEventListener('click', this.resetTimer.bind(this));
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
        hours = hours.toString().padStart(2, '0');
        minutes = minutes.toString().padStart(2, '0');
        seconds = seconds.toString().padStart(2, '0');
        // show milliseconds as three digits
        milliseconds = milliseconds.toString().padStart(3, '0');
        this.displayTarget.innerHTML = ` ${hours} : ${minutes} : ${seconds} : ${milliseconds}`;
        this.minutesTarget.value = elapsedMinutes;
      }
    };
    this.startTime = Date.now();
    int = setInterval(displayTimer, 10);
    this.int = int;
    this.minutesTarget.disabled = true;
    this.startButtonTarget.classList.add('d-none');
    this.pauseButtonTarget.classList.remove('d-none');
    this.resumeButtonTarget.classList.add('d-none');
  }

  pauseTimer() {
    clearInterval(this.int);
    this.paused = true;
    this.minutesTarget.disabled = false;
    this.startButtonTarget.classList.add('d-none');
    this.pauseButtonTarget.classList.add('d-none');
    this.resumeButtonTarget.classList.remove('d-none');
    }

  resumeTimer() {
    this.startTime = Date.now() - this.elapsedTime;
    this.paused = false;
    this.minutesTarget.disabled = true;
    this.startTimer();
    }

  resetTimer() {
    clearInterval(this.int);
    this.elapsedTime = 0;
    this.startTime = null;
    this.startButtonTarget.classList.remove('d-none');
    this.pauseButtonTarget.classList.add('d-none');
    this.resumeButtonTarget.classList.add('d-none');
    this.displayTarget.innerHTML = '00 : 00 : 00 : 000 ';
    this.minutesTarget.value = 0;
  }
}
