 --  UI icons [icons]
  --  https://github.com/nvim-tree/nvim-web-devicons
  return {
    "nvim-tree/nvim-web-devicons",
    enabled = true,
    event = "User BaseDefered",
    opts = {
      override = {
        deb = { icon = "", name = "Deb" },
        lock = { icon = "󰌾", name = "Lock" },
        mp3 = { icon = "󰎆", name = "Mp3" },
        mp4 = { icon = "", name = "Mp4" },
        out = { icon = "", name = "Out" },
        ["robots.txt"] = { icon = "󰚩", name = "Robots" },
        ttf = { icon = "", name = "TrueTypeFont" },
        rpm = { icon = "", name = "Rpm" },
        woff = { icon = "", name = "WebOpenFontFormat" },
        woff2 = { icon = "", name = "WebOpenFontFormat2" },
        xz = { icon = "", name = "Xz" },
        zip = { icon = "", name = "Zip" },
      },
    },
    config = function(_, opts)
      require("nvim-web-devicons").setup(opts)
    end
  }
