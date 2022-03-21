#######################  LIBRARIES  #######################

import socket
import PySide2
import PySide2.QtWidgets
from page1 import Ui_MainWindow
import sys
import datetime

#######################  INITIALIZATION  #######################

app = PySide2.QtWidgets.QApplication(sys.argv)
MainWindow = PySide2.QtWidgets.QMainWindow()
ui = Ui_MainWindow()
ui.setupUi(MainWindow)
MainWindow.show()

#######################  LOGIC  #######################

socket.setdefaulttimeout(1)

def connect_start():
    ui.label_10.setText("Status")
    try:
        global target_host
        target_host = ui.lineEdit.text()
        target_port = int(ui.lineEdit_2.text())
        global target
        target = (target_host,target_port)
        global client
        client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        client.connect(target)
        ui.label_10.setText("CONNECTED SUCCESSFULLY")
    except:
        ui.label_10.setText("FAILED CHECK IP AND PORT")

# receive some data
        # response = client.recv(4)
def lamb():
    try:
        connect_start()        # client.send("GET / HTTP/1.1\r\r\n".encode())

        # client.send(/"SYN".encode())
        client.send(f"GET {target_host}/LIGHT=ON/OFF HTTP/1.1\r\r\n".encode())
        ui.label_10.setText("Successed (Lamp 1)")
        

        # print (response.decode())
        # response = ""
            
    except:
        ui.label_10.setText("Error")


def lamb2():
    try:
        connect_start()
        client.send(f"GET {target_host}/LIGHT2=ON/OFF HTTP/1.1\r\r\n".encode())
        ui.label_10.setText("Successed (Lamp 2)")
    except:
        ui.label_10.setText("Error")


def lamb3():
    try:
        connect_start()
        client.send(f"GET {target_host}/LIGHT3=ON/OFF HTTP/1.1\r\r\n".encode())
        ui.label_10.setText("Successed (Lamp 3)")
    except:
        ui.label_10.setText("Error")


def AIR_CON():
    try:
        connect_start()
        client.send(f"GET {target_host}/AIRCON=ON/OFF HTTP/1.1\r\r\n".encode())
        ui.label_10.setText("Successed (Air Cond.)")

    except:
        ui.label_10.setText("Error")


def wach_mach():
    try:
        connect_start()
        # client.send("SYN".encode())
        client.send(f"GET {target_host}/WM=ON/OFF HTTP/1.1\r\r\n".encode())
        client.send("ACK!".encode())
        ui.label_10.setText("Successed (Washing Machine)")
    except:
        ui.label_10.setText("Error")

def all():
    client.send("SYN".encode())
    client.send(f"GET {target_host}/LIGHT=ON/OFF HTTP/1.1\r\r\n".encode())
    client.send(f"GET {target_host}/LIGHT2=ON/OFF HTTP/1.1\r\r\n".encode())
    client.send(f"GET {target_host}/LIGHT3=ON/OFF HTTP/1.1\r\r\n".encode())
    client.send(f"GET {target_host}/AIRCON=ON/OFF HTTP/1.1\r\r\n".encode())
    client.send(f"GET {target_host}/WM=ON/OFF HTTP/1.1\r\r\n".encode())
    client.send("ACK!".encode())



#######################  CONNECT TO FUNCIONs  #######################

ui.pushButton.clicked.connect(lamb)
ui.pushButton_2.clicked.connect(wach_mach)
ui.pushButton_3.clicked.connect(lamb2)
ui.pushButton_4.clicked.connect(AIR_CON)
ui.pushButton_5.clicked.connect(lamb3)



sys.exit(app.exec_())