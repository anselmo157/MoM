import sys

from pathlib import Path

from PySide2.QtGui import QGuiApplication

from PySide2.QtQml import QQmlApplicationEngine

from PySide2.QtCore import QObject, Slot, Signal

import random

import paho.mqtt.client as paho

from queue import Queue

topics  = []
queueMessagesList = []

queueMessages = Queue()

class Client(QObject):
    isConnect = "Desconectado"
    clientConnect = False

    def __init__(self):
        QObject.__init__(self)

        self.broker = 'broker.emqx.io'
        self.port = 1883
        self.client_id = f'python-mqtt-{random.randint(0, 1000)}'
        self.client = self.connectMqtt()
        self.checkUnsend()
        self.client.loop_start()

    @Slot(str)
    def printText(self, text):
        print(text)

    @Slot()
    def connectMqtt(self):
        def on_connect(client, userdata, flags, rc):
            client.subscribe('Geral')
            if rc == 0:
                self.isConnect = "Conectado"
            else:
                self.isConnect = "Desconectado"

        def on_message(client, userdata, msg):  # The callback for when a PUBLISH =
            payloadMsg = msg.payload.decode()
            payloadMessage = "[{}] {}".format(msg.topic, str(payloadMsg))
            queueMessages.put(payloadMessage)

        client = paho.Client(self.client_id)
        client.on_connect = on_connect
        client.on_message = on_message
        client.connect(self.broker, self.port)
        return client

    @Slot()
    def disconnectMqtt(self):
        self.client.disconnect()
        self.client.loop_stop()

    @Slot()
    def checkUnsend(self):
        if queueMessagesList != []:
            for message in queueMessagesList:
                self.publish(message[0], message[1])

    @Slot(str)
    def subscribeTopic(self, topic):
        self.client.subscribe(topic)

    @Slot(str,str)
    def publish(self, msg, topic):
        result = self.client.publish(topic, msg)
        status = result[0]
        if status == 0:
            print(f"Send `{msg}` to topic `{topic}`")
        else:
            print(f"Failed to send message to topic {topic}")

    @Slot()
    def connect(self):
        if(self.clientConnect == False):
            if(self.isConnect == "Conectado"):
                print("Conectado ao MQTT Broker!")
                self.clientConnect = True
            else :
                print("Failed to connect, return code %d\n", rc)

if __name__ == "__main__":
 
    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()

    client = Client()
    engine.rootContext().setContextProperty("backend", client)

    qml_file = Path(__file__).resolve().parent / "main.qml"

    engine.load(str(qml_file))

    if not engine.rootObjects():

        sys.exit(-1)

    sys.exit(app.exec_())

