class MriUploadController {
    static get $inject() {
        return [
            '$scope',
            '$http'
        ];
    }

    constructor(...dependencies) {
        [
            this.$scope,
            this.$http
        ] = dependencies;

        this._updateConfig();
    }

    _updateConfig() {
        AWS.config.update({
            accessKeyId: window.awskey,
            secretAccessKey: window.awssecret,
            region: window.region,
            sessionToken: window.sessionToken,
            maxRetries: 4
        });
    }

    _saveImagePath(filePath) {
        let authToken = document.getElementsByName('authenticity_token')[0].value;
        return this.$http.post(`/patients/${window.patientId}/mri_images/new`, {
            authenticity_token: authToken,
            filePath
        });
    }

    uploadToAws() {
        let bucket = window.s3Bucket;
        let file = document.getElementById('file-input-field').files[0];
        let filePath = `upload/${Math.floor(Math.random() * 1000000000).toString()}/${file.name}`;

        let s3Service = new AWS.S3.ManagedUpload({
            partSize: 5242880,
            queueSize: 10,
            params: {
                Bucket: bucket,
                Key: filePath,
                ContentType: file.type,
                Body: file,
                ACL: 'public-read'
            }
        });

        s3Service.on('httpUploadProgress', (progress) => {
            if (progress.loaded && progress.total) {
                this.percentLoaded = Math.floor((Number(progress.loaded) / Number(progress.total) * 100));
                this.$scope.$digest();
            }
        });

        this.uploading = true;
        s3Service.send((error) => {
            if (error) {
                alert('there was an error');
            } else {
                this._saveImagePath(filePath)
                    .then(() => {
                        window.location = `/patients/${window.patientId}/mri_images`;
                    });
            }

            this.uploading = false;
            this.$scope.$digest();
        });
    }
}

angular.module('mriUploadApp', [])
    .controller('MriUploadController', MriUploadController);