mkdir -p output
#docker run --rm \
#        -v $PWD/output:/worker/outputs/txt2img-samples/samples \
#        $CWD "$@"
nvidia-docker run -v $PWD/output:/worker/outputs/txt2img-samples/samples -t test1 "this is an image of a cat"
