#!/bin/sh

set -e


RELEASES="
    razorqt:RazorQt-Dev:12.1.5:
"
# clean up obsolete stuff
rm -f	./debian/*.install \
	./debian/*.links \
	./debian/*.postinst \
	./debian/*.postrm

#write toplevel Makefile
for i in $RELEASES; do
	ALL_CODENAME_SAFE="${ALL_CODENAME_SAFE} $(echo ${i} | cut -d\: -f1)"
done
sed	-e "s/\@ALL_CODENAME_SAFE\@/${ALL_CODENAME_SAFE}/g" \
		./debian/templates/Makefile.in \
			> ./Makefile

[ -d ./debian ] || exit 1

TEMPLATE_CHANGELOG="./debian/templates/changelog.in"
sed     -e s/\@CODENAME_SAFE\@/$(echo ${i} | cut -d\: -f1)/g \
              ${TEMPLATE_CHANGELOG} > ./debian/changelog

TEMPLATE_SRC="./debian/templates/control.source.in"
sed     -e s/\@CODENAME_SAFE\@/$(echo ${i} | cut -d\: -f1)/g \
              ${TEMPLATE_SRC} > ./debian/control

for i in $RELEASES; do

	# write debian/control from templates
	TEMPLATES_BIN="./debian/templates/control.binary.in"

	sed	-e s/\@CODENAME_SAFE\@/$(echo ${i} | cut -d\: -f1)/g \
		-e s/\@CODENAME\@/$(echo ${i} | cut -d\: -f2)/g \
		-e s/\@VERSION\@/$(echo ${i} | cut -d\: -f3)/g \
			${TEMPLATES_BIN} >> ./debian/control

	# write debian/*.install from templates
	for j in razorqt wallpaper; do
		if [ -r  ./debian/templates/siduction-art-${j}-CODENAME_SAFE.install.in ]; then
			sed	-e s/\@CODENAME_SAFE\@/$(echo ${i} | cut -d\: -f1)/g \
					./debian/templates/siduction-art-${j}-CODENAME_SAFE.install.in \
						> ./debian/siduction-art-${j}-$(echo ${i} | cut -d\: -f1).install
		else
			continue
		fi
	done

	# link KDE4 style wallpapers to /usr/share/wallpapers/
	sed	-e s/\@CODENAME_SAFE\@/$(echo ${i} | cut -d\: -f1)/g \
			./debian/templates/siduction-art-wallpaper-CODENAME_SAFE.links.in \
				> ./debian/siduction-art-wallpaper-$(echo ${i} | cut -d\: -f1).links
done