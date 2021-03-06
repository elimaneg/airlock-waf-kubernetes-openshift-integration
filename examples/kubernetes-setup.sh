#!/bin/bash
#

. kubernetes/script/kubernetes-lib.sh

usage()
{
 	echo "Usage: $0 --clean|--add-event-listener|--add-backend|--add-ingress|--show-event-listener-logs"
 	echo "   eg: $0 --clean"
 	exit 1
}

if [[  $# -eq 0 ]]; then
    usage
fi

while [[ $# -gt 0 ]]; do
	case "${1}" in
		--clean)
 			shift 1
 			CLEAN=true
 			;;
		--add-event-listener)
 			shift 1
 			EVENT_LISTENER=true
 			;;
		--add-backend)
 			shift 1
 			BACK_END=true
 			;;
		--add-ingress)
			shift 1
			INGRESS=true
			;;
		--show-event-listener-logs)
			shift 1
			SHOW_LOGS=true
			;;
 		*)
 			usage
 			exit 1
			;;
 	esac
done

WORKSPACE=`pwd`
ROOT_PROJECT=${WORKSPACE}/..
KUBERNETES_CONFIGS=${WORKSPACE}/kubernetes/config
EVENT_LISTENER_RESOURCES=${ROOT_PROJECT}/event-listener/src/main/resources

if [[ ${CLEAN} ]]; then
    cleanup
fi
if [[ ${EVENT_LISTENER} ]]; then
    build
    deployEventListener
fi
if [[ ${BACK_END} ]]; then
    deployBackEndApplication
fi
if [[ ${INGRESS} ]]; then
    configureIngress
fi
if [[ ${SHOW_LOGS} ]]; then
    showEventListenerLogs
fi