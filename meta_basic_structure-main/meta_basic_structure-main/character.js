export class Character {
  constructor(canvasWidth, canvasHeight) {
    this.X = canvasWidth * 0.5;
    this.Y = canvasHeight * 0.5;

    this.direction = 1;
    this.speed = 2;
    this.count = 0;
  }
  draw(ctx) {
    this.countCheck();
    this.hat(ctx);
    if (this.direction === 0) {
      this.body_behind(ctx);
    }
    if (this.direction !== 0) {
      this.body_front(ctx);
    }
  }

  hat(ctx) {
    ctx.beginPath();
    ctx.fillStyle = "#000";
    ctx.arc(this.X + 25, this.Y + 10, 10, 0, Math.PI * 2, false);

    ctx.fill();
  }
  body_front(ctx) {
    // count++;
    const CharImg = new Image();
    CharImg.src = "images/cat_front.png";
    ctx.drawImage(CharImg, this.X, this.Y, 40, 40);
  }
  body_behind(ctx) {
    // count++;
    const CharImg = new Image();
    CharImg.src = "images/cat_behind.png";
    ctx.drawImage(CharImg, this.X, this.Y, 40, 40);
  }
  countCheck() {
    if (this.count < 40 / this.speed) {
      this.count++;
      //   console.log(this.char.direction);
      this.characterMove();
    }
  }
  characterMove() {
    switch (this.direction) {
      case 0:
        this.Y -= this.speed;
        break;
      case 1:
        this.Y += this.speed;
        break;
      case 2:
        this.X -= this.speed;
        break;
      case 3:
        this.X += this.speed;
        break;
      default:
        return;
    }
  }
}
