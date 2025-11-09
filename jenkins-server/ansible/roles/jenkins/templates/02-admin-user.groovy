import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()
def hudsonRealm= new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin","password")//replace with the desired username and password
instance.HudsonPrivateSecurityRealm(hudsonRealm)
instance.save()