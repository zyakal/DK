export class Map {
  constructor(canvasWidth, canvasHeight) {
    this.canvasWidth = canvasWidth;
    this.canvasHeight = canvasHeight;

    this.strokeColor = "#fff";
    this.fillColor = "#008B8B";
  }

  draw(ctx) {
    this.grid(ctx);
  }
  grid(ctx) {
    ctx.strokeStyle = this.strokeColor;
    ctx.fillStyle = this.fillColor;
    ctx.fillRect(0, 0, this.canvasWidth, this.canvasHeight);

    //가로줄
    for (let i = 0; i < this.canvasWidth; i += 40) {
      ctx.beginPath();
      ctx.moveTo(0, i - 38);
      ctx.lineTo(this.canvasWidth, i - 38);
      ctx.stroke();
      ctx.closePath();
    }
    //세로줄
    for (let i = 0; i < this.canvasHeight; i += 40) {
      ctx.beginPath();
      ctx.moveTo(i - 25, 0);
      ctx.lineTo(i - 25, this.canvasHeight);
      ctx.stroke();
      ctx.closePath();
    }
  }
}

var map = {
  cols: 12,
  rows: 12,
  tsize: 64,
  layers: [[
      3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
      3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3,
      3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3,
      3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3,
      3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3,
      3, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 3,
      3, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3,
      3, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3,
      3, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 3,
      3, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 3,
      3, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 3,
      3, 3, 3, 1, 1, 2, 3, 3, 3, 3, 3, 3
  ], [
      4, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4,
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,
      4, 0, 0, 5, 0, 0, 0, 0, 0, 5, 0, 4,
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,
      4, 4, 4, 0, 5, 4, 4, 4, 4, 4, 4, 4,
      4, 4, 4, 0, 0, 3, 3, 3, 3, 3, 3, 3
  ]],
  getTile: function (layer, col, row) {
      return this.layers[layer][row * map.cols + col];
  },
  isSolidTileAtXY: function (x, y) {
      var col = Math.floor(x / this.tsize);
      var row = Math.floor(y / this.tsize);

      // tiles 3 and 5 are solid -- the rest are walkable
      // loop through all layers and return TRUE if any tile is solid
      return this.layers.reduce(function (res, layer, index) {
          var tile = this.getTile(index, col, row);
          var isSolid = tile === 3 || tile === 5;
          return res || isSolid;
      }.bind(this), false);
  },
  getCol: function (x) {
      return Math.floor(x / this.tsize);
  },
  getRow: function (y) {
      return Math.floor(y / this.tsize);
  },
  getX: function (col) {
      return col * this.tsize;
  },
  getY: function (row) {
      return row * this.tsize;
  }
};
