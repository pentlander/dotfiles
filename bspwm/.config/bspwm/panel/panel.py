from subprocess import Popen, PIPE, check_output
from threading import Thread
from time import sleep
import re
import colors

SCREEN_WIDTH = check_output(['sres', '-W']).decode('utf-8').strip()
FONT = 'sans-serif'
FONT_SIZE = 11


class PanelInput():
    """docstring for PanelInput"""
    def __init__(self, cmd, align='left', 
                 expr=None, action=None):
        super().__init__()
        self.cmd = cmd
        self.pos = 0
        self.align = align
        self.width = 0

    def update(self, format_line=None):
        line = check_output(self.cmd).decode('utf-8').strip()
        if format_line is None:
            format_line = self.format_line
        line = format_line(line)

        position = self.get_position()
        line = '^pa({}){}'.format(position, line)
        return line

    def get_position(self):
        position = self.pos
        if (self.align == 'right'):
            position = int(SCREEN_WIDTH) - self.width - position
        return position

    def set_width(self, line):
        self.width = int(check_output(['txtw', '-f', FONT, '-s',
                         str(FONT_SIZE), line]).decode('utf-8'))

    def format_line(self, line):
        formatter = FormatOutput()
        self.set_width(line)
        return formatter.format_line(line, foreground=colors.FOREGROUND, background=colors.BACKGROUND)

    def bind(self, output_pipe):
        def f():
            input_pipe = self.subprocess.stdout
            try:
                print(input_pipe)
                for line in iter(input_pipe.readline, b''):
                    line = self.format_line(line)
                    if (line):
                        output_pipe.write(line)
                        output_pipe.flush()
            finally:
                try:
                    output_pipe.close()
                finally:
                    input_pipe.close()
        t = Thread(target=f)
        t.daemon = True
        t.start()


class FormatOutput():
    def __init__(self, font='sans-serif', font_size=11, align='left'):
        super().__init__()
        self.font = font
        self.font_size = font_size

    def format_line(self, line, foreground='', background='', action=''):
        if action:
            line = '^ca(1{}){}^ca()'.format(action, line)
        if background:
            line = '^bg({}){}'.format(background, line)
        if foreground:
            line = '^fg({}){}'.format(foreground, line)
        return line

    def apply_regex(self, line):
        regex = re.compile(self.regex)
        output = regex.search(line)
        return ' '.join(output.groups())


class Widget():
    """Class to build a generic dzen Widget"""
    def __init__(self, pos=(0, 0), height=24, font='sans-serif', font_size=11):
        super().__init__()
        self.pos = pos
        self.font = font
        self.font_size = font_size
        self.height = height
        self.subprocess = None
        global FONT, FONT_SIZE
        FONT = font
        FONT_SIZE = font_size

    def run(self, slave=0):
        foreground = ['-fg', colors.FOREGROUND]
        background = ['-bg', colors.BACKGROUND]
        screen_width = ['-w', SCREEN_WIDTH]
        height = ['-h', str(self.height)]
        x = ['-x', str(self.pos[0])]
        y = ['-y', str(self.pos[1])]
        alignment = ['-ta', 'l']
        title = ['-title-name', 'panel']
        font = ['-fn', ''.join([self.font, ':pixelsize=', str(self.font_size)])]
        cmd = ['dzen2', '-p'] + foreground + background + screen_width + height\
            + x + y + alignment + title + font
        if slave:
            cmd.append(['-l', str(slave)])
        print(cmd)
        self.subprocess = Popen(cmd, stdin=PIPE, bufsize=1)

    def update(self, line):
        stdin = self.subprocess.stdin
        stdin.write(line)
        stdin.flush()


class PanelBar(Widget):
    """docstring for Widget"""
    def __init__(self, height=24, font='sans-serif', font_size=11):
        super().__init__(pos=(0, 30), height=height, font=font, font_size=font_size)

    def run_panel(self, panel_inputs):
        self.run()
        while True:
            output = []
            align_left = align_right = 10
            for panel_input in panel_inputs:
                if (panel_input.align == 'left'):
                    panel_input.pos = align_left
                    output.append(panel_input.update())
                    align_left += panel_input.width
                elif (panel_input.align == 'right'):
                    panel_input.pos = align_right
                    output.append(panel_input.update())
                    align_right += panel_input.width + 10
            output.append('\n')
            line = ' '.join(output)
            line = bytes(line, 'utf-8')
            print(line)
            self.update(line)
            sleep(1)


def main():
    inputs = []
    date_input = PanelInput(['date'], align='right')
    inputs.append(date_input)
    mpc_input = PanelInput(['ncmpcpp', '--now-playing'], action='echo pressed')
    inputs.append(mpc_input)
    test_input = PanelInput(['echo', 'testing'])
    inputs.append(test_input)

    panel = PanelBar()
    panel.run_panel(inputs)

if __name__ == '__main__':
    main()