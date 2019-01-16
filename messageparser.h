#ifndef MESSAGEPARSER_H
#define MESSAGEPARSER_H

#include <QObject>
#include <QDebug>
#include <QDomDocument>

class MessageParser : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString response READ response WRITE setResponse)
public:
    MessageParser();

    QString response() { return  m_response; }

    Q_INVOKABLE void setResponse(const QString &response) {
        //qDebug() << "!!!  " << QTextDocumentFragment::fromHtml(response).toPlainText();
        if (!response.isEmpty()) {
            if (setContent(response))
                qDebug() << "response loaded ";

            if (!m_response.isEmpty()) {
                qDebug() << m_response;
                emit appendText(m_response);
            }
        }
    }

signals:
    void appendText(QString str);

private:
    bool setContent(const QString &content);
    bool parseDomDocument(const QDomElement &root);

    QString m_response;
    QDomDocument domDocument;
};

#endif // MESSAGEPARSER_H
