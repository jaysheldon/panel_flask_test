import panel as pn
import param
import logging
import sys

# Configure logging to output to the console
logging.basicConfig(stream=sys.stdout, level=logging.INFO)
logger = logging.getLogger(__name__)

pn.extension()

class MyPanelApp(param.Parameterized):
    title = param.String(default="Panel App")
    text = param.String(default="This is a simple Panel app.")
    slider_value = param.Number(default=0, bounds=(0, 100))

    @param.depends("slider_value")
    def slider_value_output(self):
        logger.info(f"Slider value changed to {self.slider_value}")
        return "Slider value: " + str(self.slider_value)

    def display(self):
        slider_param_widget = pn.Param(
            self.param.slider_value, widgets={"slider_value": pn.widgets.FloatSlider}
        )   
        return pn.Column(
            pn.pane.Markdown(f"# {self.title}"),
            pn.pane.Markdown(self.text),
            slider_param_widget,
            pn.pane.Str(self.slider_value_output),
        )

    def view(self):
        return pn.Column(
           self.display()
        )


app = MyPanelApp()
pn.Column(app.view()).servable()
logger.info("Panel app is ready to be served")
print("Panel app is ready to be served")  # For debugging
