#include "messageparser.h"

#include <QTextDocumentFragment>
#include <QTextCodec>
#include <QDebug>
#include <QFile>
#include <QDir>

MessageParser::MessageParser()
{
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));
}

bool MessageParser::setContent(const QString &content)
{
    QString error_string;
    int error_row;
    int error_column;
    if (!domDocument.setContent(content, true, &error_string, &error_row, &error_column)) {
        qDebug() << QString("DOM error - parse error line %1, column %2: \n%3")
                    .arg(error_row)
                    .arg(error_column)
                    .arg(error_string);
        return false;
    }
    return parseDomDocument(domDocument.documentElement());
}

bool MessageParser::parseDomDocument(const QDomElement &root)
{
    if (root.tagName() != QLatin1String("program_o")) {
        qDebug() << QString("DOM error - the response not valid");
        return false;
    }

    QString bot_name, bot_message, user_name, user_message;

    QDomElement child = root.firstChildElement();
    while (!child.isNull()) {
        if (child.tagName() == QLatin1String("version")) {
            qDebug() << child.tagName()
                     << " " << child.text();
        } else if (child.tagName() == QLatin1String("status")) {
            qDebug() << child.tagName()
                     << " " << child.text();
        } else if (child.tagName() == QLatin1String("bot_id")) {
            qDebug() << child.tagName()
                     << " " << child.text();
        } else if (child.tagName() == QLatin1String("bot_name")) {
            bot_name = child.text();
            qDebug() << child.tagName()
                     << " " << bot_name;
        } else if (child.tagName() == QLatin1String("user_id")) {
            qDebug() << child.tagName()
                     << " " << child.text();
        } else if (child.tagName() == QLatin1String("user_name")) {
            user_name = child.text();
            qDebug() << child.tagName()
                     << " " << user_name;
        } else if (child.tagName() == QLatin1String("chat")) {
            QDomElement line = child.firstChildElement(QLatin1String("line"));

            QDomElement input = line.firstChildElement(QLatin1String("input"));
            user_message = QTextDocumentFragment::fromHtml(input.text()).toPlainText();
            qDebug() << input.tagName()
                     << " " << user_message;
            QDomElement response = line.firstChildElement(QLatin1String("response"));
            bot_message = QTextDocumentFragment::fromHtml(response.text()).toPlainText();
            qDebug() << response.tagName()
                     << " " << bot_message;
        }
        child = child.nextSiblingElement();
    }
    m_response.clear();
    m_response = user_name + " : " + user_message + "\n" + bot_name + " : " + bot_message + "\n";

    return true;
}
