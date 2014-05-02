from subprocess import Popen, PIPE, check_output
from threading import Thread
from time import sleep
import re
import sys
import colors

SCREEN_WIDTH = check_output(['sres', '-W']).decode('utf-8')

class PanelInput():
	"""docstring for PanelInput"""
	def __init__(self, cmd, align='left', expr=None, action=None):
		super().__init__()
		self.cmd = cmd
		self.align = align
		self.expr = expr
		self.pos = 0
		self.width = 0
		self.action = action 

	def update(self, font, font_size):
		line = check_output(self.cmd).decode('utf-8')
		if (self.expr):
			line = self.format_text(line)
		self.width = int(check_output(['txtw', '-f', font, '-s', str(font_size), line]).decode('utf-8'))
		line = self.format_line(line)
		return line

	def format_line(self, line):
		position = self.pos
		click = ['', '']
		if (self.align == 'right'):
			position = int(SCREEN_WIDTH) - self.width - position
		if (self.action):
			click[0] = '^ca(1, ' + self.action + ')'
			click[1] = '^ca()'

		line = '^fg(' + colors.STATUS_FG + ')^bg(' +\
			colors.STATUS_BG + ')^pa(' + str(position) + ')' +\
			click[0] + line + click[1]

		#print(line)
		return line.strip()

	def format_text(self, line):
		regex = re.compile(self.expr)
		output = regex.search(line)
		return ' '.join(output.groups())


	def bind(self, output_pipe):
		def f():
			input_pipe = self.subprocess.stdout
			try:
				print(input_pipe)
				for line in iter(input_pipe.readline, b''):
					line = self.format_line(line)
					if (line):
						output_pipe.write(line) # no flush unless newline present
						output_pipe.flush()
			finally:
				try:
					output_pipe.close()
				finally:
					input_pipe.close()
		t = Thread(target=f)
		t.daemon = True # die if the program exits
		t.start()

class PanelBar():
	"""docstring for Panel"""
	def __init__(self, pos=(0,0), height=24, font='sans-serif', font_size=11):
		super().__init__()
		self.pos = pos
		self.font = font
		self.font_size = font_size
		self.height = height
		self.subprocess = None
		
	def run(self, slave=0):
		font = self.font + ':pixelsize=' + str(self.font_size)
		cmd = ['dzen2', '-p', '-fg', colors.FOREGROUND, '-bg', colors.BACKGROUND,\
			'-w', SCREEN_WIDTH, '-h', str(self.height),\
			'-x',str(self.pos[0]), '-y', str(self.pos[1]),\
			'-ta', 'l',	'-title-name', 'panel',\
			'-fn', font]
		if slave:
			cmd.append(['-l', str(slave)])
		self.subprocess = Popen(cmd, stdin=PIPE, bufsize=1)

	def update(self, line):
		stdin = self.subprocess.stdin
		stdin.write(line)
		stdin.flush()

class Widget(PanelBar):
	"""docstring for Widget"""
	def __init__(self, height=24, font='sans-serif', font_size=11):
		super().__init__(height, font, font_size)
		self.y_pos = y_pos

date_input = PanelInput(['date'], align='right')
#battery_input = PanelInput(['acpi'], align='left', expr="\w \d: ([A-Z])[a-z]+\, (\d+%), 0(\d+:\d+)", action='echo hi')
panel = PanelBar(pos=(0, 30))
panel.run()

inputs = []
inputs.append(date_input)
#inputs.append(battery_input)
while True:
	output = []
	align_left = align_right = 10
	for panel_input in inputs:
		if (panel_input.align == 'left'):
			panel_input.pos = align_left
			output.append(panel_input.update(panel.font, panel.font_size))
			align_left += panel_input.width
		elif (panel_input.align == 'right'):
			panel_input.pos = align_right
			output.append(panel_input.update(panel.font, panel.font_size))
			align_right += panel_input.width + 10
	output.append('\n')
	line = ' '.join(output)
	line = bytes(line, 'utf-8')
	panel.update(line)
	sleep(1)
