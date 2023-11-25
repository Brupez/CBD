import json
from random import randint

USERS = [ 'planetafford', 'sonsandals', 'mearasnervous', 'whisperedhubbles', 'bakerauthentic', 'fideliusadorable', 'fannyangelic', 'journalistsnob', 'mithrilbitch', 'themselvesbenefit' ]
# 10 | From https://jimpix.co.uk/words/random-username-list.asp
NAMES = [ 'Hannah Macmillan', 'Ellamae Wardle', 'Leonila Holbrook', 'June Dougherty', 'Basilia Schur', 'Jennefer Cathcart', 'Mathilda Gervasi', 'Anneliese Yardley', 'Ozie Wigfall', 'Renita Camille' ]
# 10 | From http://listofrandomnames.com/index.cfm?generated
TITLES = [ 'Clinical Costing and the Value of Patient Care', 'Innovative Applications of Mobile Technologies in Maternal Health and Newborn Care', 'Semiotics and Brand Building: Rethinking Consumer Messaging, Signs, and Symbols', 'Metacognition and Learning Strategies in the Age of Globalization', 'Advancing Employee Engagement Using Lean Six Sigma', 'Examining the Changing Role of Communication in the Digital Age', 'Advanced Instrumentation Methods in Chemoinformatics and Analytical Chemistry', 'Multilayer Neural Networks: Overview and Applications', 'Key Competencies and Contemporary Skill Development in Education', 'Routing Protocols and Graph Theory Algorithms for Mobile Ad Hoc Networks', 'Using Cross-Culture Design-Based Research Frameworks: Creating Mobile Learning Solutions in the Medical Profession', 'Microfinance and the Implications of the Global Economic Crisis', 'Effective Telementoring Partnerships in Digital Learning Environments', 'Emergent Technologies and the Changing Pace of Clinical Development in the Pharmaceutical Industry', 'Using Forensic Readiness and E-Discovery in Quality Information Risk Management Planning', 'Social Media Influence on Global Democratic Practices', 'High Accuracy Orbit Determination for Spacecraft Flybys', 'Global Language Learning Solutions using Online Text-Based Chat', 'Cognitive Modeling Systems in Information Technology, Psychology, and Business', 'Occlusal Diseases and the Impact of Microtrauma' ]
# 20 | From https://www.igi-global.com/distributors/e-resources/videos-title-list/
TAGS = ['Health Information Systems', 'Medical Technologies', 'Marketing', 'Instructional Design', 'Human Aspects of Business', 'Human-Computer Interaction', 'Chemoinformatics', 'Neural Networks', 'Theoretical Studies', 'Algorithms', 'Educational Technologies', 'Economics & Economic Theory', 'Web-Based Teaching & Learning', 'Pharmaceutical Technologies', 'Digital Crime & Forensics', 'Civic Engagement & Social Justice', 'Aerospace Engineering', 'Computer-Assisted Language Learning', 'Cognitive Science', 'Dentistry', 'Urban & Regional Development', 'Human Aspects of Business', 'Electrical Engineering', 'Humanities Education', 'Accounting & Finance', 'Electrical Engineering', 'Public Health & Healthcare Delivery', 'Systems & Software Design', 'Systems & Software Design', 'Artificial Intelligence', 'Computer Vision & Image Processing', 'Human Aspects of Technology', 'Information Security & Privacy', 'Information Security & Privacy', 'Artificial Intelligence', 'Web-Based Teaching & Learning', 'Computer-Assisted Language Learning', 'Theoretical Studies', 'Computer Vision & Image Processing', 'Knowledge Management', 'Cloud Computing', 'Supply Chain Management', 'Accounting & Finance', 'Accounting & Finance', 'Electrical Engineering', 'Ethics & Law', 'Accounting & Finance', 'Theoretical Studies', 'Environmental Technologies', 'Social Networking', 'Information Security & Privacy', 'Adult Learning', 'K-12 Education', 'Systems & Software Design', 'Knowledge Management', 'Instructional Design', 'Digital Communications', 'Robotics', 'Computer Simulation', 'Artificial Intelligence', 'Civil Engineering', 'Semantic Web', 'Neural Networks', 'Professional Development', 'Artificial Intelligence', 'Educational Technologies', 'Web-Based Teaching & Learning', 'Social Networking', 'Human Aspects of Business', 'Culture & Population Studies', 'Library Science', 'Data Warehousing', 'Digital Crime & Forensics', 'Virtual Communities & Virtual Reality', 'Social Networking', 'Computer Simulation', 'Gender & Technology', 'Medical Education', 'Web Technologies & Engineering', 'E-Commerce' ]
# 80 | A lot from https://www.igi-global.com/distributors/e-resources/videos-title-list/
EVENTS = [ 'play', 'pause', 'stop' ]

def randomTime():
    return f'2020-{randint(1,12):02}-{randint(1,28):02}T{randint(0,23):02}:{randint(0,59):02}:{randint(0,59):02}.000+0000'


VIDEOS = []

# Generate 20 videoid
for i in range(0,20):
    n = randint(1000, 9999)
    while n in VIDEOS:
        n = randint(1000, 9999)
    VIDEOS.append(n)


# Create 10 users
i = 0
for u in USERS:
    user = {
        'username': u,
        'name': NAMES[i],
        'email': f'{u}@sapo.pt',
        'registerMoment': randomTime(),
    }

    print(f"INSERT INTO users JSON '{json.dumps(user)}';")

    i += 1

print("\n\n\n")


# Create 20 videos
# Assign it to random user
# Define 2 to 5 random tags
i = 0
for vid in VIDEOS:
    video = {
        'videoid': vid,
        'author': USERS[randint(0, len(USERS)-1)],
        'name': TITLES[i],
        'description': 'Lorem ipsum...',
        'tags': [TAGS[randint(0, len(TAGS)-1)] for x in range(0,randint(2,5))],
        'uploadMoment': randomTime(),
    }
    print(f"INSERT INTO videos JSON '{json.dumps(video)}';")
    i += 1

print("\n\n\n")

# Generate 5 comments foreach video (100)
# Assign it to random user
for vid in VIDEOS:
    for i in range(0,5):
        comment = {
            'id': randint(1000,9999),
            'author': USERS[randint(0, len(USERS)-1)],
            'moment': randomTime(),
            'videoid': vid,
            'comment': 'Loren ipsum...'
        }

        print(f"INSERT INTO comments JSON '{json.dumps(comment)}';")


print("\n\n\n")

# Make each user follow 3 to 5 random videos (30 to 50)
for user in USERS:
    for i in range(0,randint(3,5)):
        follow = {
            'videoid': VIDEOS[randint(0, len(VIDEOS)-1)],
            'username': user
        }

        print(f"INSERT INTO videoFollowers JSON '{json.dumps(follow)}';")

print("\n\n\n")


# Foreach video generate 5 events foreach user (1000)
for v in VIDEOS:
    for u in USERS:
        for i in range(0,5):
            event = {
                'videoid': v,
                'username': u,
                'type': EVENTS[randint(0, len(EVENTS)-1)],
                'moment': randomTime(),
                'videomoment': randint(10, 600)
            }

            print(f"INSERT INTO events JSON '{json.dumps(event)}';")

print("\n\n\n")


# Genarate between 10 to 20 ratings foreach video (200 to 400)
for v in VIDEOS:
    for i in range(0, randint(10,20)):
        rating = {
            'videoid': v,
            'rating': randint(1,5),
            'ratingid': randint(1000,9999)
        }

        print(f"INSERT INTO ratings JSON '{json.dumps(rating)}';")