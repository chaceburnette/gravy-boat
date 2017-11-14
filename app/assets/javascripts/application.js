
function uploadToAws() {
    AWS.config.update({
        accessKeyId: window.awskey,
        secretAccessKey: window.awssecret,
        region: window.region,
        sessionToken: window.sessionToken,
        maxRetries: 4
    });

    var bucket = window.s3Bucket;
    var file = document.getElementById('file-input-field').files[0];
    var fileName = `${Math.floor(Math.random() * 1000000000).toString()}.zip`;
    var key = 'upload/' + fileName;

    var s3Service = new AWS.S3.ManagedUpload({
        partSize: 5242880,
        queueSize: 10,
        params: {
            Bucket: bucket,
            Key: key,
            ContentType: file.type,
            Body: file,
            ACL: 'public-read'
        }
    });

    s3Service.on('httpUploadProgress', (progress) => {
        if (progress.loaded && progress.total) {
            var percentLoaded = Math.floor((Number(progress.loaded) / Number(progress.total) * 100));
            document.getElementById('upload-progress').innerHTML = percentLoaded + "%";
        }
    });

    s3Service.send((error) => {
        if (error) {

        }
    });
}