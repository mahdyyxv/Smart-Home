# -*- coding: utf-8 -*-

################################################################################
## Form generated from reading UI file 'MAINGBkFtH.ui'
##
## Created by: Qt User Interface Compiler version 5.14.1
##
## WARNING! All changes made in this file will be lost when recompiling UI file!
################################################################################

from PySide2.QtCore import (QCoreApplication, QMetaObject, QObject, QPoint,
    QRect, QSize, QUrl, Qt)
from PySide2.QtGui import (QBrush, QColor, QConicalGradient, QCursor, QFont,
    QFontDatabase, QIcon, QLinearGradient, QPalette, QPainter, QPixmap,
    QRadialGradient)
from PySide2.QtWidgets import *
import PySide2.QtWidgets


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        if MainWindow.objectName():
            MainWindow.setObjectName(u"MainWindow")
        MainWindow.resize(447, 360)
        self.centralwidget = QWidget(MainWindow)
        self.centralwidget.setObjectName(u"centralwidget")
        self.label = QLabel(self.centralwidget)
        self.label.setObjectName(u"label")
        self.label.setGeometry(QRect(30, 30, 421, 91))
        font = QFont()
        font.setPointSize(18)
        self.label.setFont(font)
        self.label_2 = QLabel(self.centralwidget)
        self.label_2.setObjectName(u"label_2")
        self.label_2.setGeometry(QRect(50, 150, 361, 21))
        font1 = QFont()
        font1.setPointSize(12)
        self.label_2.setFont(font1)
        self.label_3 = QLabel(self.centralwidget)
        self.label_3.setObjectName(u"label_3")
        self.label_3.setGeometry(QRect(50, 250, 101, 21))
        font2 = QFont()
        font2.setPointSize(10)
        self.label_3.setFont(font2)
        self.pushButton = QPushButton(self.centralwidget)
        self.pushButton.setObjectName(u"pushButton")
        self.pushButton.setGeometry(QRect(50, 280, 93, 28))
        self.pushButton_2 = QPushButton(self.centralwidget)
        self.pushButton_2.setObjectName(u"pushButton_2")
        self.pushButton_2.setGeometry(QRect(300, 280, 93, 28))
        self.label_4 = QLabel(self.centralwidget)
        self.label_4.setObjectName(u"label_4")
        self.label_4.setGeometry(QRect(290, 250, 131, 21))
        self.label_4.setFont(font2)
        MainWindow.setCentralWidget(self.centralwidget)
        self.statusbar = QStatusBar(MainWindow)
        self.statusbar.setObjectName(u"statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)

        QMetaObject.connectSlotsByName(MainWindow)
    # setupUi

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(QCoreApplication.translate("MainWindow", u"MainWindow", None))
        self.label.setText(QCoreApplication.translate("MainWindow", u"WELCOME TO SMART HOME ", None))
        self.label_2.setText(QCoreApplication.translate("MainWindow", u"PLEASE TELL ME WHAT DO YOU WANT ", None))
        self.label_3.setText(QCoreApplication.translate("MainWindow", u"NODE SETUP", None))
        self.pushButton.setText(QCoreApplication.translate("MainWindow", u"SETUP", None))
        self.pushButton_2.setText(QCoreApplication.translate("MainWindow", u"CONTROL", None))
        self.label_4.setText(QCoreApplication.translate("MainWindow", u"NODE CONTROL", None))
    # retranslateUi

if __name__ == "__main__":
    import sys
    app = PySide2.QtWidgets.QApplication(sys.argv)
    MainWindow = PySide2.QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())
