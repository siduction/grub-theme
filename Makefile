#!/usr/bin/make -f

include ./VERSION

all: background logo font icons menu slider highlight userpass themetxt livetxt
icons: theme/icons/*.svg

dir:
	mkdir -p build/$(CODENAME_SAFE)

iconsdir:
	mkdir -p build/$(CODENAME_SAFE)/icons

background: dir
	inkscape --without-gui \
		 --export-width=1024 \
		 --export-height=768 \
		 --export-png="build/$(CODENAME_SAFE)/$@.png" \
			svg/$@.svg

logo: dir
	inkscape --without-gui \
		 --export-width=1024 \
		 --export-height=100 \
		 --export-png="build/$(CODENAME_SAFE)/logo.png" \
			svg/logo.svg

userpass: dir
	inkscape --without-gui \
		 --export-png="build/$(CODENAME_SAFE)/userpass.png" \
			theme/userpass.svg

font: dir
	grub-mkfont -s 16 -o build/$(NAME)/u_vga16_16.pf2 u_vga16.bdf

slider_n: dir
	inkscape --without-gui \
		--export-area=0:16:32:32 \
		--export-png="build/$(CODENAME_SAFE)/slider_n.png" \
			theme/dot_white.svg

slider_c: dir
	inkscape --without-gui \
		--export-area=0:16:32:17 \
		--export-png="build/$(CODENAME_SAFE)/slider_c.png" \
			theme/dot_white.svg

slider_s: dir
	inkscape --without-gui \
		--export-area=0:0:32:16 \
		--export-png="build/$(CODENAME_SAFE)/slider_s.png" \
			theme/dot_white.svg

slider: slider_n slider_c slider_s

menu_e: dir
	inkscape --without-gui \
		--export-area=16:16:32:17 \
		--export-png="build/$(CODENAME_SAFE)/menu_e.png" \
			theme/dot_black.svg

menu_c: dir
	inkscape --without-gui \
		--export-area=16:16:17:17 \
		--export-png="build/$(CODENAME_SAFE)/menu_c.png" \
			theme/dot_black.svg

menu: menu_c menu_e

highlight_w: dir
	inkscape --without-gui \
		--export-area=0:0:16:32 \
		--export-png="build/$(CODENAME_SAFE)/highlight_w.png" \
			theme/dot_black.svg

highlight_c: dir
	inkscape --without-gui \
		--export-area=16:0:17:32 \
		--export-png="build/$(CODENAME_SAFE)/highlight_c.png" \
			theme/dot_black.svg

highlight_e: dir
	inkscape --without-gui \
		--export-area=16:0:32:32 \
		--export-png="build/$(CODENAME_SAFE)/highlight_e.png" \
			theme/dot_black.svg

highlight: highlight_w highlight_c highlight_e

theme/icons/*.svg: iconsdir
	inkscape --without-gui \
		--export-width=32 \
		--export-height=32 \
		--export-png="$(patsubst theme/icons/%.svg,build/$(CODENAME_SAFE)/icons/%.png,$@)" \
			$@

themetxt:
	cp -v theme/theme.txt build/$(NAME)

livetxt:
	cp -a build/$(NAME) build/$(CODENAME_SAFE)-live
	cp -v theme/theme-live.txt build/$(CODENAME_SAFE)-live/theme.txt


clean:
	$(RM) -r build
