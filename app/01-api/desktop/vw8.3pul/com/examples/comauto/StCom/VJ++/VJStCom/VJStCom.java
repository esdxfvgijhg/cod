//******************************************************************************
// VJStCom.java:	Applet
//
//******************************************************************************
import java.applet.*;
import java.awt.*;
import VJStComFrame;
import vwstcom.*;

//==============================================================================
// Main Class for applet VJStCom
//
//==============================================================================
public class VJStCom extends Applet implements Runnable
{
	// THREAD SUPPORT:
	//		m_VJStCom	is the Thread object for the applet
	//--------------------------------------------------------------------------
	private Thread	 m_VJStCom = null;

	// ANIMATION SUPPORT:
	//		m_Graphics		used for storing the applet's Graphics context
	//		m_Images[]		the array of Image objects for the animation
	//		m_nCurrImage	the index of the next image to be displayed
	//		m_ImgWidth		width of each image
	//		m_ImgHeight		height of each image
	//		m_fAllLoaded	indicates whether all images have been loaded
	//		NUM_IMAGES 		number of images used in the animation
	//--------------------------------------------------------------------------
	private Graphics m_Graphics;
	private Image	 m_Images[];
	private int 	 m_nCurrImage;
	private int 	 m_nImgWidth  = 0;
	private int 	 m_nImgHeight = 0;
	private boolean  m_fAllLoaded = false;
	private final int NUM_IMAGES = 18;

	// STANDALONE APPLICATION SUPPORT:
	//		m_fStandAlone will be set to true if applet is run standalone
	//--------------------------------------------------------------------------
	private boolean m_fStandAlone = false;

	// PARAMETER SUPPORT:
	//		Parameters allow an HTML author to pass information to the applet;
	// the HTML author specifies them using the <PARAM> tag within the <APPLET>
	// tag.  The following variables are used to store the values of the
	// parameters.
    //--------------------------------------------------------------------------

    // Members for applet parameters
    // <type>       <MemberVar>    = <Default Value>
    //--------------------------------------------------------------------------
	private String m_arg1 = "";
	private String m_arg2 = "";
	private String m_arg3 = "";
	private String m_arg4 = "";

    // Parameter names.  To change a name of a parameter, you need only make
	// a single change.  Simply modify the value of the parameter string below.
    //--------------------------------------------------------------------------
	private final String PARAM_arg1 = "arg1";
	private final String PARAM_arg2 = "arg2";
	private final String PARAM_arg3 = "arg3";
	private final String PARAM_arg4 = "arg4";

	// GG UI elements
	// Label
	private Label m_labelEval = new Label("Enter a Smalltalk expression:");

	// Smalltalk text pane
	private TextArea m_STText = new TextArea("100 factorial", 5, 40);

	// Evaluate button
	private Button m_EvalButton = new Button("Evaluate");

	// Answer text pane
	private TextArea m_AnswerText = new TextArea(10, 40);

	// The Smalltalk Commander
	private ISmalltalkCommanderDisp m_StCom = (ISmalltalkCommanderDisp)new VWSmalltalkCommander();


	// STANDALONE APPLICATION SUPPORT
	// 	The GetParameter() method is a replacement for the getParameter() method
	// defined by Applet. This method returns the value of the specified parameter;
	// unlike the original getParameter() method, this method works when the applet
	// is run as a standalone application, as well as when run within an HTML page.
	// This method is called by GetParameters().
	//---------------------------------------------------------------------------
	String GetParameter(String strName, String args[])
	{
		if (args == null)
		{
			// Running within an HTML page, so call original getParameter().
			//-------------------------------------------------------------------
			return getParameter(strName);
		}

		// Running as standalone application, so parameter values are obtained from
		// the command line. The user specifies them as follows:
		//
		//	JView VJStCom param1=<val> param2=<"val with spaces"> ...
		//-----------------------------------------------------------------------
		int    i;
		String strArg	= strName + "=";
		String strValue = null;
		int    nLength  = strArg.length();

		try
		{
			for (i = 0; i < args.length; i++)
			{
				String strParam = args[i].substring(0, nLength);

				if (strArg.equalsIgnoreCase(strParam))
				{
					// Found matching parameter on command line, so extract its value.
					// If in double quotes, remove the quotes.
					//---------------------------------------------------------------
					strValue = args[i].substring(nLength);
					if (strValue.startsWith("\""))
					{
						strValue = strValue.substring(1);
						if (strValue.endsWith("\""))
							strValue = strValue.substring(0, strValue.length() - 1);
					}
					break;
				}
			}
		}
		catch (Exception e)
		{
			// TODO: Place exception-handling code here in case an
		}

		return strValue;
	}

	// STANDALONE APPLICATION SUPPORT
	// 	The GetParameters() method retrieves the values of each of the applet's
	// parameters and stores them in variables. This method works both when the
	// applet is run as a standalone application and when it's run within an HTML
	// page.  When the applet is run as a standalone application, this method is
	// called by the main() method, which passes it the command-line arguments.
	// When the applet is run within an HTML page, this method is called by the
	// init() method with args == null.
	//---------------------------------------------------------------------------
	void GetParameters(String args[])
	{
		// Query values of all Parameters
		//--------------------------------------------------------------
		String param;

		// arg1: Parameter description
		//--------------------------------------------------------------
		param = GetParameter(PARAM_arg1, args);
		if (param != null)
			m_arg1 = param;

		// arg2: Parameter description
		//--------------------------------------------------------------
		param = GetParameter(PARAM_arg2, args);
		if (param != null)
			m_arg2 = param;

		// arg3: Parameter description
		//--------------------------------------------------------------
		param = GetParameter(PARAM_arg3, args);
		if (param != null)
			m_arg3 = param;

		// arg4: Parameter description
		//--------------------------------------------------------------
		param = GetParameter(PARAM_arg4, args);
		if (param != null)
			m_arg4 = param;

	}

	// STANDALONE APPLICATION SUPPORT
	// 	The main() method acts as the applet's entry point when it is run
	// as a standalone application. It is ignored if the applet is run from
	// within an HTML page.
	//--------------------------------------------------------------------------
	public static void main(String args[])
	{
		// Create Toplevel Window to contain applet VJStCom
		//----------------------------------------------------------------------
		VJStComFrame frame = new VJStComFrame("VJStCom");

		// Must show Frame before we size it so insets() will return valid values
		//----------------------------------------------------------------------
		frame.show();
        frame.hide();
		frame.resize(frame.insets().left + frame.insets().right  + 320,
					 frame.insets().top  + frame.insets().bottom + 240);

		// The following code starts the applet running within the frame window.
		// It also calls GetParameters() to retrieve parameter values from the
		// command line, and sets m_fStandAlone to true to prevent init() from
		// trying to get them from the HTML page.
		//----------------------------------------------------------------------
		VJStCom applet_VJStCom = new VJStCom();

		frame.add("Center", applet_VJStCom);
		applet_VJStCom.m_fStandAlone = true;
		applet_VJStCom.GetParameters(args);
		applet_VJStCom.init();
		applet_VJStCom.start();
        frame.show();
	}

	// VJStCom Class Constructor
	//--------------------------------------------------------------------------
	public VJStCom()
	{
		// TODO: Add constructor code here
	}

	// APPLET INFO SUPPORT:
	//		The getAppletInfo() method returns a string describing the applet's
	// author, copyright date, or miscellaneous information.
    //--------------------------------------------------------------------------
	public String getAppletInfo()
	{
		return "Name: VJStCom\r\n" +
		       "Author: Gary Gregory\r\n" +
		       "Created with Microsoft Visual J++ Version 1.1\r\n" +
		       "Copyright 1997 ParcPlace-Digitalk, Inc.";
	}

	// PARAMETER SUPPORT
	//		The getParameterInfo() method returns an array of strings describing
	// the parameters understood by this applet.
	//
    // VJStCom Parameter Information:
    //  { "Name", "Type", "Description" },
    //--------------------------------------------------------------------------
	public String[][] getParameterInfo()
	{
		String[][] info =
		{
			{ PARAM_arg1, "String", "Parameter description" },
			{ PARAM_arg2, "String", "Parameter description" },
			{ PARAM_arg3, "String", "Parameter description" },
			{ PARAM_arg4, "String", "Parameter description" },
		};
		return info;		
	}

	// The init() method is called by the AWT when an applet is first loaded or
	// reloaded.  Override this method to perform whatever initialization your
	// applet needs, such as initializing data structures, loading images or
	// fonts, creating frame windows, setting the layout manager, or adding UI
	// components.
    //--------------------------------------------------------------------------
	public void init()
	{
		if (!m_fStandAlone)
			GetParameters(null);
        // If you use a ResourceWizard-generated "control creator" class to
        // arrange controls in your applet, you may want to call its
        // CreateControls() method from within this method. Remove the following
        // call to resize() before adding the call to CreateControls();
        // CreateControls() does its own resizing.
        //----------------------------------------------------------------------
    	resize(320, 240);

		// TODO: Place additional initialization code here
		m_AnswerText.setForeground(Color.blue);
		
		setLayout(new BorderLayout());
		add("North", m_labelEval);
		add("East", m_EvalButton);
		add("West", m_STText);
		add("South", m_AnswerText);
	}

	public boolean action(Event event, Object obj)
	{
		Object oTarget = event.target;
		if (oTarget instanceof Button)
		{
			Button buttonTarget = (Button)oTarget;
			String sButtonString = buttonTarget.getLabel();
			if (sButtonString.compareTo("Evaluate") == 0)
			{
				String s = m_STText.getText();
				m_AnswerText.setText("Thinking...");
				String answer = m_StCom.EvaluateAsString(s);
				m_AnswerText.setText(answer);
				return true;
			}
		}
		return false;
	}

	// Place additional applet clean up code here.  destroy() is called when
	// when you applet is terminating and being unloaded.
	//-------------------------------------------------------------------------
	public void destroy()
	{
		// TODO: Place applet cleanup code here
	}

    // ANIMATION SUPPORT:
    //		Draws the next image, if all images are currently loaded
    //--------------------------------------------------------------------------
	private void displayImage(Graphics g)
	{
		if (!m_fAllLoaded)
			return;

		// Draw Image in center of applet
		//----------------------------------------------------------------------
		/*g.drawImage(m_Images[m_nCurrImage],
				   (size().width - m_nImgWidth)   / 2,
				   (size().height - m_nImgHeight) / 2, null);*/
	}

	// VJStCom Paint Handler
	//--------------------------------------------------------------------------
	public void paint(Graphics g)
	{
		// ANIMATION SUPPORT:
		//		The following code displays a status message until all the
		// images are loaded. Then it calls displayImage to display the current
		// image.
		//----------------------------------------------------------------------
		if (m_fAllLoaded)
		{
			Rectangle r = g.getClipRect();
			
			g.clearRect(r.x, r.y, r.width, r.height);
			displayImage(g);
		}
		else
			g.drawString("Loading images...", 10, 20);

		// TODO: Place additional applet Paint code here
	}

	//		The start() method is called when the page containing the applet
	// first appears on the screen. The AppletWizard's initial implementation
	// of this method starts execution of the applet's thread.
	//--------------------------------------------------------------------------
	public void start()
	{
		if (m_VJStCom == null)
		{
			m_VJStCom = new Thread(this);
			m_VJStCom.start();
		}
		// TODO: Place additional applet start code here
	}
	
	//		The stop() method is called when the page containing the applet is
	// no longer on the screen. The AppletWizard's initial implementation of
	// this method stops execution of the applet's thread.
	//--------------------------------------------------------------------------
	public void stop()
	{
		if (m_VJStCom != null)
		{
			m_VJStCom.stop();
			m_VJStCom = null;
		}

		// TODO: Place additional applet stop code here
	}

	// THREAD SUPPORT
	//		The run() method is called when the applet's thread is started. If
	// your applet performs any ongoing activities without waiting for user
	// input, the code for implementing that behavior typically goes here. For
	// example, for an applet that performs animation, the run() method controls
	// the display of images.
	//--------------------------------------------------------------------------
	public void run()
	{
		m_nCurrImage = 0;
		
		// If re-entering the page, then the images have already been loaded.
		// m_fAllLoaded == TRUE.
		//----------------------------------------------------------------------
        if (!m_fAllLoaded)
		{
    		repaint();
    		m_Graphics = getGraphics();
    		m_Images   = new Image[NUM_IMAGES];

    		// Load in all the images
    		//------------------------------------------------------------------
    		MediaTracker tracker = new MediaTracker(this);
    		String strImage;

    		// For each image in the animation, this method first constructs a
    		// string containing the path to the image file; then it begins
    		// loading the image into the m_Images array.  Note that the call to
    		// getImage will return before the image is completely loaded.
    		//------------------------------------------------------------------
    		for (int i = 1; i <= NUM_IMAGES; i++)
    		{
    			// Build path to next image
    			//--------------------------------------------------------------
    			strImage = "images/img00" + ((i < 10) ? "0" : "") + i + ".gif";
    			if (m_fStandAlone)
    				m_Images[i-1] = Toolkit.getDefaultToolkit().getImage(strImage);
    			else
    				m_Images[i-1] = getImage(getDocumentBase(), strImage);

                tracker.addImage(m_Images[i-1], 0);
    		}

    		// Wait until all images are fully loaded
    		//------------------------------------------------------------------
			try
			{
				tracker.waitForAll();
				m_fAllLoaded = !tracker.isErrorAny();
			}
			catch (InterruptedException e)
			{
				// TODO: Place exception-handling code here in case an
				//       InterruptedException is thrown by Thread.sleep(),
				//		 meaning that another thread has interrupted this one
			}
			
			if (!m_fAllLoaded)
			{
			    stop();
			    m_Graphics.drawString("Error loading images!", 10, 40);
			    return;
			}
			

			// Assuming all images are same width and height.
			//--------------------------------------------------------------
		    m_nImgWidth  = m_Images[0].getWidth(this);
		    m_nImgHeight = m_Images[0].getHeight(this);
        }		
		repaint();

		while (true)
		{
			try
			{
				// Draw next image in animation
				//--------------------------------------------------------------
				displayImage(m_Graphics);
				m_nCurrImage++;
				if (m_nCurrImage == NUM_IMAGES)
					m_nCurrImage = 0;

				// TODO:  Add additional thread-specific code here
				Thread.sleep(50);
			}
			catch (InterruptedException e)
			{
				// TODO: Place exception-handling code here in case an
				//       InterruptedException is thrown by Thread.sleep(),
				//		 meaning that another thread has interrupted this one
				stop();
			}
		}
	}

	// MOUSE SUPPORT:
	//		The mouseDown() method is called if the mouse button is pressed
	// while the mouse cursor is over the applet's portion of the screen.
	//--------------------------------------------------------------------------
	public boolean mouseDown(Event evt, int x, int y)
	{
		// TODO: Place applet mouseDown code here
		return true;
	}

	// MOUSE SUPPORT:
	//		The mouseUp() method is called if the mouse button is released
	// while the mouse cursor is over the applet's portion of the screen.
	//--------------------------------------------------------------------------
	public boolean mouseUp(Event evt, int x, int y)
	{
		// TODO: Place applet mouseUp code here
		return true;
	}


	// TODO: Place additional applet code here

}


/*---------------------------------------------------------------------------
  GG: Imported COM Interface:

public interface vwstcom/ISmalltalkCommanderDisp extends com.ms.com.IUnknown
{
    public abstract java.lang.String EvaluateAsString(java.lang.String);
    public abstract com.ms.com.Variant Evaluate(java.lang.String);
    public abstract void Quit();
}
public class vwstcom/VWSmalltalkCommander extends java.lang.Object
{
}
---------------------------------------------------------------------------*/