from pynput.keyboard import Listener as KeyboardListener
from pynput.mouse import Listener as MouseListener
import datetime
import time
import logging
import threading
import os
from logging.handlers import TimedRotatingFileHandler
from threading import Thread
import os
import re
import subprocess
from subprocess import PIPE, Popen
# import reos.kill(12345, signal.SIGKILL)
import signal

formatter = logging.Formatter('%(asctime)s %(message)s', '%Y-%m-%d %H:%M:%S')
te = None

# cmd = ['pgrep -af python']
# process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, 
# stderr=subprocess.PIPE)
def remove(string):
    return string.replace(" ", "")
current_pid = int(os.getpid())
print(current_pid,"--currentId")

proc_list = subprocess.check_output("pgrep -f .*python.*event_logger.py", shell=True, universal_newlines=True)
pross = {}
list = proc_list.split("\n")

for p in list:
    print(p, current_pid, type(p), type(current_pid), p==current_pid)
    
    if(p!=""):
        p = int(p);
        if p!=current_pid and p>0:
            print("kill id",p)
            try:
                os.kill(p, 9)
            except :
                pass   
        else:
            print("currentId", current_pid);    
            
def setup_logger_k(name, log_file, level=logging.INFO):
    time = datetime.datetime.now().strftime('%d_%m_%Y')
    handler = logging.FileHandler(os.environ['HOME']+"/Workstatus"+"/keyboard_library/"+time+"/"+ log_file)
    handler.setFormatter(formatter)
    logger = logging.getLogger(name)
    logger.setLevel(level)
    logger.addHandler(handler)
    return logger


time_now = datetime.datetime.now().strftime('%H_%d_%m_%Y_keyboard.txt')
keyboard_logger = setup_logger_k('keyboard_logger', time_now)      


def on_press(key):
    global te
    ts = datetime.datetime.now().strftime('%d_%m_%Y %H:%M:%S')
    if te == ts:
        pass
    else:
        global time_now
        global keyboard_logger
        if(time_now==datetime.datetime.now().strftime('%H_%d_%m_%Y_keyboard.txt')):
            keyboard_logger.info('')
            te = datetime.datetime.now().strftime('%d_%m_%Y %H:%M:%S')
        else:
            time_now = datetime.datetime.now().strftime ('%H_%d_%m_%Y_keyboard.txt')
            keyboard_logger= None
            time.sleep(2)
            keyboard_logger = setup_logger_k('keyboard_logger', time_now)
            keyboard_logger.info('')
        te = datetime.datetime.now().strftime('%d_%m_%Y %H:%M:%S')      

def on_release(key):
    pass
   

formatter = logging.Formatter('%(asctime)s %(message)s', '%Y-%m-%d %H:%M:%S')
te = None

def setup_logger_m(name, log_file, level=logging.INFO):
    time = datetime.datetime.now().strftime('%d_%m_%Y')
    handler = logging.FileHandler(os.environ['HOME']+"/Workstatus"+"/mouse_library/"+time+"/" + log_file)
    handler.setFormatter(formatter)
    logger = logging.getLogger(name)
    logger.setLevel(level)
    logger.addHandler(handler)
    return logger


time_now_mouse = datetime.datetime.now().strftime('%H_%d_%m_%Y_mouse.txt')

mouse_logger = setup_logger_m('mouse_logger', time_now_mouse)


def on_move(x, y):
    global te
    ts = datetime.datetime.now().strftime('%d_%m_%Y %H:%M:%S')
    if te == ts:
        pass
    else:
        global time_now_mouse
        global mouse_logger
        if(time_now_mouse==datetime.datetime.now().strftime('%H_%d_%m_%Y_mouse.txt')):
            mouse_logger.info('')
            te = datetime.datetime.now().strftime('%d_%m_%Y %H:%M:%S')
        else:
            time_now_mouse = datetime.datetime.now().strftime('%H_%d_%m_%Y_mouse.txt')
            mouse_logger= None
            time.sleep(2)
            mouse_logger =  setup_logger_m('mouse_logger', time_now_mouse)
            mouse_logger.info('')
    te = datetime.datetime.now().strftime('%d_%m_%Y %H:%M:%S')


def on_click(x, y, button, pressed):
    global te 
    ts = datetime.datetime.now().strftime('%d_%m_%Y %H:%M:%S')
    if te == ts:
        pass
    else:
        global time_now_mouse
        global mouse_logger
        if(time_now_mouse==datetime.datetime.now().strftime('%H_%d_%m_%Y_mouse.txt')):
            mouse_logger.info('')
            te = datetime.datetime.now().strftime('%d_%m_%Y %H:%M:%S')
        else:
            time_now_mouse = datetime.datetime.now().strftime('%H_%d_%m_%Y_mouse.txt')
            mouse_logger= None
            time.sleep(2)
            mouse_logger =  setup_logger_m('mouse_logger', time_now_mouse)
            mouse_logger.info('')
    te = datetime.datetime.now().strftime('%d_%m_%Y %H:%M:%S')


def on_scroll(x, y, dx, dy):
    global te
    ts = datetime.datetime.now().strftime('%d_%m_%Y %H:%M:%S')
    if te == ts:
        pass
    else:
        global time_now_mouse
        global mouse_logger
        if(time_now_mouse==datetime.datetime.now().strftime('%H_%d_%m_%Y_mouse.txt')):
            mouse_logger.info('')
            te = datetime.datetime.now().strftime('%d_%m_%Y %H:%M:%S')
        else:
            time_now_mouse = datetime.datetime.now().strftime('%H_%d_%m_%Y_mouse.txt')
            mouse_logger= None
            time.sleep(2)
            mouse_logger =  setup_logger_m('mouse_logger', time_now_mouse)
            mouse_logger.info('')
    te = datetime.datetime.now().strftime('%d_%m_%Y %H:%M:%S')

def main():

    keyboard_listener = KeyboardListener(
        on_press=on_press, on_release=on_release)
    mouse_listener = MouseListener(
        on_move=on_move, on_click=on_click, on_scroll=on_scroll)
    keyboard_listener.start()
    mouse_listener.start()
    mouse_listener.join()
    keyboard_listener.join() 




if __name__ == "__main__":
    main()