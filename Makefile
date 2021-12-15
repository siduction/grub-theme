#!/usr/bin/make -f

include ./VERSION

all: background logo font icons menu slider highlight userpass themetxt livetxt tick center
icons: theme/icons/*.svg

dir:
	mkdir -p build/$(CODENAME_SAFE)

iconsdir:
	mkdir -p build/$(CODENAME_SAFE)/icons

background: dir
	inkscape \
		 --export-width=1024 \
		 --export-height=768 \
		 --export-filename="build/$(CODENAME_SAFE)/$@.png" \
			svg/$@.svg

logo: dir
	inkscape \
		 --export-width=196 \
		 --export-height=38 \
		 --export-filename="build/$(CODENAME_SAFE)/logo.png" \
			svg/logo.svg

userpass: dir
	inkscape \
		 --export-filename="build/$(CODENAME_SAFE)/userpass.png" \
			theme/userpass.svg

tick: dir
	cp -v theme/tick.png build/$(CODENAME_SAFE)

center: dir
	cp -v theme/center.png build/$(CODENAME_SAFE)

font: dir
	grub-mkfont -s 16 -o build/$(NAME)/u_vga16_16.pf2 template/u_vga16.bdf

slider_n: dir
	inkscape \
		--export-area=0:16:32:32 \
		--export-filename="build/$(CODENAME_SAFE)/slider_n.png" \
			theme/dot_white.svg

slider_c: dir
	inkscape \
		--export-area=0:16:32:17 \
		--export-filename="build/$(CODENAME_SAFE)/slider_c.png" \
			theme/dot_white.svg

slider_s: dir
	inkscape \
		--export-area=0:0:32:16 \
		--export-filename="build/$(CODENAME_SAFE)/slider_s.png" \
			theme/dot_white.svg

slider: slider_n slider_c slider_s

menu_e: dir
	inkscape \
		--export-area=16:16:32:17 \
		--export-filename="build/$(CODENAME_SAFE)/menu_e.png" \
			theme/dot_black.svg

menu_c: dir
	inkscape \
		--export-area=16:16:17:17 \
		--export-filename="build/$(CODENAME_SAFE)/menu_c.png" \
			theme/dot_black.svg

menu: menu_c menu_e

highlight_w: dir
	inkscape \
		--export-area=0:0:16:32 \
		--export-filename="build/$(CODENAME_SAFE)/highlight_w.png" \
			theme/dot_black.svg

highlight_c: dir
	inkscape \
		--export-area=16:0:17:32 \
		--export-filename="build/$(CODENAME_SAFE)/highlight_c.png" \
			theme/dot_black.svg

highlight_e: dir
	inkscape \
		--export-area=16:0:32:32 \
		--export-filename="build/$(CODENAME_SAFE)/highlight_e.png" \
			theme/dot_black.svg

highlight: highlight_w highlight_c highlight_e

theme/icons/*.svg: iconsdir
	inkscape \
		--export-width=32 \
		--export-height=32 \
		--export-filename="$(patsubst theme/icons/%.svg,build/$(CODENAME_SAFE)/icons/%.png,$@)" \
			$@

themetxt:
	cp -v theme/theme.txt build/$(CODENAME_SAFE)

livetxt:
	cp -a build/$(CODENAME_SAFE) build/$(CODENAME_SAFE)-live
	cp -v theme/theme-live.txt build/$(CODENAME_SAFE)-live/theme.txt


clean:
	$(RM) -r build
