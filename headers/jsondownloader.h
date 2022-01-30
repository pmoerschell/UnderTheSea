#ifndef JSONDOWNLOADER_H
#define JSONDOWNLOADER_H

#include <QObject>
#include <QByteArray>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>

class JsonDownloader : public QObject
{
    Q_OBJECT

    public:
        explicit JsonDownloader();
        virtual ~JsonDownloader();
        Q_INVOKABLE void fetchJson(QUrl jsonUrl);
        Q_INVOKABLE QByteArray downloadedJson() const;

    signals:
        void downloaded();

    private slots:
        void jsonDownloaded(QNetworkReply* pReply);

    private:
        QNetworkAccessManager m_manager;
        QByteArray m_DownloadedJson;
};

#endif // JSONDOWNLOADER_H
