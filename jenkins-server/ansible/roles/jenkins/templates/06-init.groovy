import jenkins.model.Jenkins

def instance = Jenkins.getInstanceOrNull()

if (instance == null) {
    println "Jenkins instance is not available. Skipping bind change."
    return
}

def newPort = 8080
def newAddress = "127.0.0.1"

def currentConnector = instance.getDescriptor("jenkins.model.JenkinsLocationConfiguration")

println "Updating Jenkins to listen only on ${newAddress}:${newPort}"

def args = ["--httpPort=${newPort}", "--httpListenAddress=${newAddress}"]
instance.servletContext.setAttribute("appArguments", args)

println "Bind configuration updated. Restart Jenkins to apply."
