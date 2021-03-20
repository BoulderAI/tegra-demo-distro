#! /bin/bash
set -e

PROGNAME=$(basename $0)

usage()
{
    cat >&2 <<EOF
Usage: $PROGNAME --machine <MACHINE> --image <IMAGE>
Options:
    -h, --h             Print this usage message
    -m, --machine       Set the MACHINE used for this script
    -i, --image         Set the IMAGE used for this script
Arguments:
Examples:
- To deploy a demo-image-base image for jetson-xavier-nx-devkit machine:
  $ $0 --machine jetson-xavier-nx-devkit  --image demo-image-base
EOF
}

# get command line options
SHORTOPTS="hm:i:"
LONGOPTS="help,machine:,image:"

ARGS=$(getopt --options $SHORTOPTS --longoptions $LONGOPTS --name $PROGNAME -- "$@" )
if [ $? != 0 ]; then
   usage
   exit 1
fi

eval set -- "$ARGS"
while true;
do
    case $1 in
        -h | --help)       usage; exit 0 ;;
        -m | --machine)    MACHINE="$2"; shift 2;;
        -i | --image)      IMAGE="$2"; shift 2;;
        -- )               shift; break ;;
        * )                break ;;
    esac
done

if [ -z "$MACHINE" ]; then
    echo "You must specify a machine"
    usage
    exit 1
fi

if [ -z "$IMAGE" ]; then
    echo "You must specify an image"
    usage
    exit 1
fi

echo "Using machine ${MACHINE} image ${IMAGE}"
deployfile=${IMAGE}-${MACHINE}.tegraflash.tar.gz
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
tmpdir=`mktemp`
rm -rf $tmpdir
mkdir -p $tmpdir
echo "Using temp directory $tmpdir"
pushd $tmpdir
cp $scriptdir/../../../build/tmp/deploy/images/${MACHINE}/$deployfile .
tar -xvf $deployfile
sudo ./doflash.sh
popd
echo "Removing temp directory $tmpdir"
rm -rf $tmpdir
