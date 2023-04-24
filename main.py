import sys

from pathlib import Path

from PySide2.QtGui import QGuiApplication

from PySide2.QtQml import QQmlApplicationEngine

import random

import paho.mqtt.client as paho

topics  = []
queueMessages = []

class Client():
    def __init__(self, main):
        super().__init__()

        self.broker = 'broker.emqx.io'
        self.port = 1883
        self.client_id = f'python-mqtt-{random.randint(0, 1000)}'
        self.mainWindow = main

        self.client = self.connectMqtt()
        self.checkUnsend()
        self.client.loop_start()
    
    def connectMqtt(self):
        def on_connect(client, userdata, flags, rc):
            client.subscribe('Geral')
            if rc == 0:
                print("Conectado ao MQTT Broker!")
            else:
                print("Failed to connect, return code %d\n", rc)

        def on_message(client, userdata, msg):  # The callback for when a PUBLISH =
            payloadMessage = "[{}] {}".format(msg.topic, str(msg.payload))
            self.mainWindow.adicionaMensagens(payloadMessage)
            print("Message received-> " + msg.topic + " " + str(msg.payload))  # Print a received msg

        client = paho.Client(self.client_id)
        client.on_connect = on_connect
        client.on_message = on_message
        client.connect(self.broker, self.port)
        return client

    def disconnectMqtt(self):
        self.client.disconnect()
        self.client.loop_stop()

    def checkUnsend(self):
        if queueMessages != []:
            for message in queueMessages:
                self.publish(message[0], message[1])

    def subscribeTopic(self, topic):
        self.client.subscribe(topic)

    def publish(self, msg, topic):
        result = self.client.publish(topic, msg)
        status = result[0]
        if status == 0:
            print(f"Send `{msg}` to topic `{topic}`")
        else:
            print(f"Failed to send message to topic {topic}")


if __name__ == "__main__":
 
    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()

    qml_file = Path(__file__).resolve().parent / "main.qml"

    engine.load(str(qml_file))

    if not engine.rootObjects():

        sys.exit(-1)

    sys.exit(app.exec_())

