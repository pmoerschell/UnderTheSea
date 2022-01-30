#include "../headers/jsondownloader.h"

// JsonDownloader::JsonDownloader(QUrl jsonUrl, QObject *parent) :
JsonDownloader::JsonDownloader() { }
JsonDownloader::~JsonDownloader() { }

void JsonDownloader::fetchJson(QUrl jsonUrl) {
    // initialize the network request
    QNetworkRequest request(jsonUrl);
    // connect the finished signal to the handler
    connect(
        &m_manager, SIGNAL (finished(QNetworkReply*)),
        this, SLOT (jsonDownloaded(QNetworkReply*))
    );
    m_manager.get(request);
}

void JsonDownloader::jsonDownloaded(QNetworkReply* pReply) {
    m_DownloadedJson = pReply->readAll();
    // emit signal indicating download is complete
    pReply->deleteLater();
    emit downloaded();
}

QByteArray JsonDownloader::downloadedJson() const {
    return m_DownloadedJson;
}
