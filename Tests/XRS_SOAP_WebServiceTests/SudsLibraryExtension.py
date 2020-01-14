import suds.bindings
from robot.libraries.BuiltIn import BuiltIn, RobotNotRunningError

class SudsLibraryExtension(object):
    """
    Extension on the SudsLibrary

    """
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'    
    ROBOT_LIBRARY_VERSION = 1.0

    def __init__(self, LibraryName='SudsLibrary'):
        """SudsLibraryExtension can be imported with an optional argument.
        - ``LibraryName``:
          Default value for `LibraryName` is SudsLibrary if not given.
          The name can by any Library Name that implements or extends the
          SudsLibraryExtension.
        """        
        try:
            self.SudsLibrary = BuiltIn().get_library_instance(LibraryName)

        # This is useful for when you run Robot in Validation mode or load
        # the library in an IDE that automatically retrieves the documen-
        # tation from the library. 
        except RobotNotRunningError:
            pass

    def set_binding(self, binding, url):
        """Set Binding can be used to add a binding to the message.

        Example    Set Binding     SOAP-ENV    http://www.w3.org/2003/05/soap-envelope
        """
        suds.bindings.binding.envns = (binding, url)